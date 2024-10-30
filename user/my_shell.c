#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "kernel/param.h"
#include "user/user.h"
#include "kernel/stat.h"


#define MAX_ARGS 10
#define MAX_CMD_LEN 256
#define MaxPipes 5

// Custom tokenization function
int tokenise(char *input, char *tokens[]) {
    int num_tokens = 0;
    while (*input != '\0' && num_tokens < MAX_ARGS - 1) {
        // Skip leading whitespace
        while (*input == ' ' || *input == '\n')
            *input++ = '\0';

        if (*input != '\0') {
            tokens[num_tokens++] = input;
        }
        // Skip non-whitespace
        while (*input != ' ' && *input != '\n' && *input != '\0')
            input++;
    }
    tokens[num_tokens] = 0;
    return num_tokens;
}



//Function for Output and Input rediretcion
void redirection(char *args[]){
    int x = 0;
    for (int i=0; args[i]!=0;i++){
        if (strcmp(args[i],">")==0){
            x=1;
            if (args[i + 1] == 0) {
                printf("Usage: > filename\n");
                exit(0);
            }
            int fd1=open(args[i+1], O_WRONLY | O_CREATE | O_TRUNC );
            if (fd1<0){
                printf("Cannot open %s for writing\n",args[i+1]);
                exit(0);
            }
            close(1);
            dup(fd1);
            close(fd1);
            args[i]=0;
            args[i+1]=0;
           
            
        } 
    }     
    for (int i=0; args[i]!=0;i++){    
        if(strcmp(args[i],"<")==0){
            
            if (args[i + 1] == 0) {
                printf("Usage: > filename\n");
                exit(0);
            }
            int fd=open(args[i+1],O_RDONLY);
            if (fd<0){
                printf("Cannot open %s for reading\n",args[i+1]);
                exit(0);
            }
            close(0);
            dup(fd);
            close(fd);

            if (x==1){
                args[i]=0;     
            }else{
                args[i]=0;
                args[i+1]=0;
            }
        } 
    }     
}


void redirectionPipe(char *args[], int point, int isLastSegment) {
    for (int i = point; args[i] != 0; i++) {
        if (strcmp(args[i], ">") == 0) {
            if (args[i + 1] == 0) {
                printf("Usage: > filename\n");
                exit(0);
            }
            int fd1 = open(args[i + 1], O_CREATE | O_WRONLY | O_TRUNC);
            if (fd1 < 0) {
                printf("Cannot open %s for writing\n", args[i + 1]);
                exit(0);
            }
            close(1);
            dup(fd1);
            close(fd1);
            args[i] = 0;
            args[i + 1] = 0;
        } else if (strcmp(args[i], "<") == 0) {
            if (args[i + 1] == 0) {
                printf("Usage: < filename\n");
                exit(0);
            }
            int fd = open(args[i + 1], O_RDONLY);
            if (fd < 0) {
                printf("Cannot open %s for reading\n", args[i + 1]);
                exit(0);
            }
            close(0);
            dup(fd);
            close(fd);
            args[i] = 0;
            args[i + 1] = 0;
        } else if (isLastSegment && strcmp(args[i], ">>") == 0) {
            // Append output for the last segment of the pipeline
            if (args[i + 1] == 0) {
                printf("Usage: >> filename\n");
                exit(0);
            }
            int fd1 = open(args[i + 1], O_CREATE | O_WRONLY);
            if (fd1 < 0) {
                printf("Cannot open %s for writing\n", args[i + 1]);
                exit(0);
            }
            close(1);
            dup(fd1);
            close(fd1);
            args[i] = 0;
            args[i + 1] = 0;
        }
    }
}







void executeCommand(char *args[]){
    int pid = fork();
    if (pid < 0) {
        printf("Fork failed\n");
    } else if (pid == 0) {
        redirection(args);
        // This is the child process
        exec(args[0], args);
        // If exec fails, print an error message
        printf("Command not found: %s\n", args[0]);
        exit(0);
    } else {
        // This is the parent process
        wait(0);


    }
}


typedef struct{
    int pipe_fds[2];
    int pipe_fds1[3];
    int index[2];
} PipeDescriptor;



void createPipeDesc(PipeDescriptor *pipeDesc){
    if (pipe(pipeDesc->pipe_fds)==-1){
        printf("Pipe creation failed");
        exit(1);
    }
}

// void closePipe(PipeDescriptor *pipeDesc){
//     close(pipeDesc->pipe_fds[0]);
//     close(pipeDesc->pipe_fds[1]);
// }



void segmentHandler(char *args[], int num_args, int pipePosition[], int pipesFound) {
    PipeDescriptor pipeDesc;
    createPipeDesc(&pipeDesc);
    int pid1, pid2;
    pipeDesc.index[0] = pipePosition[0]+1;



    pid1 = fork();
    if (pid1 == 0) {
        // Child 1
        // Redirect output to the write end of the pipe
        close(pipeDesc.pipe_fds[0]);
        close(1);
        dup(pipeDesc.pipe_fds[1]);
        close(pipeDesc.pipe_fds[1]);
        
        // Execute the first command segment
        exec(args[0], args);
        // If exec fails, print an error message
        printf("Execution failed");
        exit(0);
    } else if (pid1 > 0) {
        // Parent
        close(pipeDesc.pipe_fds[1]); // Close write end in the parent

        if (pipesFound > 0) {
            // Second fork for the second command segment
            pid2 = fork();
            if (pid2 == 0) {
                // Child 2
                // Redirect input from the read end of the pipe
                close(pipeDesc.pipe_fds[1]);
                close(0);
                dup(pipeDesc.pipe_fds[0]);
                close(pipeDesc.pipe_fds[0]);

                // Execute the second command segment
                exec(args[pipeDesc.index[0]], args + pipeDesc.index[0]);
                // If exec fails, print an error message
                printf("Execution failure");
                exit(1);
            } else if (pid2 > 0) {
                // Parent
                // Wait for both child processes to finish
                wait(0);
                wait(0);
            }
        } else {
            // If no pipes, wait for the first child to finish
            wait(0);
        }
    }
    // Return to the main while loop after handling pipes
}

void multiElementPipelineHandler(char *args[], int num_args, int pipePosition[], int pipesFound) {
    PipeDescriptor pipeDesc;
    createPipeDesc(&pipeDesc);
    pipeDesc.index[0] = pipePosition[0]+1;
    pipeDesc.index[1] = pipePosition[1]+1;

    int pid1, pid2, pid3;
    pid1 = fork();
    if (pid1 == 0) {
        // Child 1
        // Redirect output to the write end of the pipe
        close(pipeDesc.pipe_fds[0]);
        close(1);
        dup(pipeDesc.pipe_fds[1]);
        close(pipeDesc.pipe_fds[1]);
        // Execute the first command segment
        redirectionPipe(args,0,0);
        exec(args[0], args);
        // If exec fails, print an error message
        printf("Execution failed");
        exit(0);
    } else if (pid1 > 0) {
        // Parent
        close(pipeDesc.pipe_fds[1]); // Close write end in the parent

        if (pipesFound > 0) {
            // Second fork for the second command segment
            pid2 = fork();
            if (pid2 == 0) {
                // Child 2
                // Redirect input from the read end of the pipe
                close(pipeDesc.pipe_fds[1]);
                close(0);
                dup(pipeDesc.pipe_fds[0]);
                close(pipeDesc.pipe_fds[0]);
                // Execute the second command segment
                redirectionPipe(args, pipeDesc.index[0],pipesFound==1);
                exec(args[pipeDesc.index[0]], args + pipeDesc.index[0] );
                // If exec fails, print an error message
                printf("Execution failure");
                exit(1);
            } else if (pid2 > 0) {
                // Parent
                // Wait for the second child process to finish
                close(pipeDesc.pipe_fds[0]);
                wait(0);
                if (pipesFound > 1) {
                    // Third fork for the third command segment
                    pid3 = fork();
                    if (pid3 == 0) {
                        // Child 3
                        // Redirect input from the read end of the second pipe
                        close(pipeDesc.pipe_fds[2]);
                        close(0);
                        dup(pipeDesc.pipe_fds[1]);
                        close(pipeDesc.pipe_fds[1]);
                        // Execute the third command segment
                        redirectionPipe(args, pipeDesc.index[1],1);
                        exec(args[pipeDesc.index[1] ], args + pipeDesc.index[1]);
                        // If exec fails, print an error message
                        printf("Execution failure");
                        exit(1);
                    } else if (pid3 > 0) {
                        // Parent
                        // Wait for the third child process to finish
                        wait(0);
                        wait(0);
                        wait(0);
                        
                    }
                }
            }else{
                wait(0);
            }
        }
    }
    // Return to the main while loop after handling pipes
}
    

int containsPipe(char *args[], int num_args) {
    int pipePosition[3];
    int pipesFound = 0;

    for (int i = 0; i < num_args; i++) {
        if (strcmp(args[i], "|") == 0) {
            args[i] = 0;
            pipePosition[pipesFound++] = i;
        }
    }

    if (pipesFound > 0) {
        if (pipesFound == 1) {
            // Single-element pipeline
            segmentHandler(args, num_args, pipePosition, pipesFound);
        } else {
            // Multi-element pipeline
            multiElementPipelineHandler(args, num_args, pipePosition, pipesFound);
        }
        return 1;
    } else {
        // No pipes found
        return 0;
    }
}


int main(int argc, char *argv[]) {
    char buf[MAX_CMD_LEN];
    char *args[MAX_ARGS];
    while (1) {
        const char* Prompt=">>> ";
        write(1,Prompt,strlen(Prompt)); 
        gets(buf, sizeof(buf));
        // Tokenize the input command
        int num_args = tokenise(buf, args);
        
        if (num_args > 0) {
            // Check for built-in commands
            if (strcmp(args[0], "cd") == 0) {
                if(num_args !=2){
                    printf("Usage: cd <directory>\n");

                }else{
                    if (chdir(args[1])<0){
                        printf("cd: cannot change directory to %s\n",args[1]);
                    }
                }    
                
            } else {
                // Fork a child process to execute the command

                if (containsPipe(args,num_args)==0){
                    executeCommand(args);
                }
              
            }
        }
    }

    return(0);
}
