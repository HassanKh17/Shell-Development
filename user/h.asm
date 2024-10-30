
user/_h:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <tokenise>:
#define MAX_ARGS 10
#define MAX_CMD_LEN 256
#define MaxPipes 5

// Custom tokenization function
int tokenise(char *input, char *tokens[]) {
   0:	1141                	addi	sp,sp,-16
   2:	e422                	sd	s0,8(sp)
   4:	0800                	addi	s0,sp,16
   6:	87aa                	mv	a5,a0
    int num_tokens = 0;
    while (*input != '\0' && num_tokens < MAX_ARGS - 1) {
   8:	00054703          	lbu	a4,0(a0)
    int num_tokens = 0;
   c:	4501                	li	a0,0
        // Skip leading whitespace
        while (*input == ' ' || *input == '\n')
   e:	02000693          	li	a3,32
  12:	4629                	li	a2,10
    while (*input != '\0' && num_tokens < MAX_ARGS - 1) {
  14:	4821                	li	a6,8
  16:	e709                	bnez	a4,20 <tokenise+0x20>
  18:	a81d                	j	4e <tokenise+0x4e>
            *input++ = '\0';
  1a:	0785                	addi	a5,a5,1
  1c:	fe078fa3          	sb	zero,-1(a5)
        while (*input == ' ' || *input == '\n')
  20:	0007c703          	lbu	a4,0(a5)
  24:	fed70be3          	beq	a4,a3,1a <tokenise+0x1a>
  28:	fec709e3          	beq	a4,a2,1a <tokenise+0x1a>

        if (*input != '\0') {
  2c:	cb0d                	beqz	a4,5e <tokenise+0x5e>
            tokens[num_tokens++] = input;
  2e:	0015089b          	addiw	a7,a0,1
  32:	050e                	slli	a0,a0,0x3
  34:	952e                	add	a0,a0,a1
  36:	e11c                	sd	a5,0(a0)
        }
        // Skip non-whitespace
        while (*input != ' ' && *input != '\n' && *input != '\0')
  38:	0007c703          	lbu	a4,0(a5)
            tokens[num_tokens++] = input;
  3c:	8546                	mv	a0,a7
        while (*input != ' ' && *input != '\n' && *input != '\0')
  3e:	02d71263          	bne	a4,a3,62 <tokenise+0x62>
  42:	a021                	j	4a <tokenise+0x4a>
    while (*input != '\0' && num_tokens < MAX_ARGS - 1) {
  44:	0007c703          	lbu	a4,0(a5)
  48:	c319                	beqz	a4,4e <tokenise+0x4e>
  4a:	fca85be3          	bge	a6,a0,20 <tokenise+0x20>
            input++;
    }
    tokens[num_tokens] = 0;
  4e:	00351793          	slli	a5,a0,0x3
  52:	95be                	add	a1,a1,a5
  54:	0005b023          	sd	zero,0(a1)
    return num_tokens;
}
  58:	6422                	ld	s0,8(sp)
  5a:	0141                	addi	sp,sp,16
  5c:	8082                	ret
        while (*input != ' ' && *input != '\n' && *input != '\0')
  5e:	0007c703          	lbu	a4,0(a5)
  62:	fec701e3          	beq	a4,a2,44 <tokenise+0x44>
  66:	df79                	beqz	a4,44 <tokenise+0x44>
            input++;
  68:	0785                	addi	a5,a5,1
        while (*input != ' ' && *input != '\n' && *input != '\0')
  6a:	0007c703          	lbu	a4,0(a5)
  6e:	fed71ae3          	bne	a4,a3,62 <tokenise+0x62>
  72:	bfe1                	j	4a <tokenise+0x4a>

0000000000000074 <redirection>:



//Function for Output and Input rediretcion
void redirection(char *args[]){
  74:	7139                	addi	sp,sp,-64
  76:	fc06                	sd	ra,56(sp)
  78:	f822                	sd	s0,48(sp)
  7a:	f426                	sd	s1,40(sp)
  7c:	f04a                	sd	s2,32(sp)
  7e:	ec4e                	sd	s3,24(sp)
  80:	e852                	sd	s4,16(sp)
  82:	e456                	sd	s5,8(sp)
  84:	e05a                	sd	s6,0(sp)
  86:	0080                	addi	s0,sp,64
  88:	8b2a                	mv	s6,a0
    int x = 0;
    for (int i=0; args[i]!=0;i++){
  8a:	6108                	ld	a0,0(a0)
  8c:	14050263          	beqz	a0,1d0 <redirection+0x15c>
  90:	008b0913          	addi	s2,s6,8
  94:	84ca                	mv	s1,s2
    int x = 0;
  96:	4a01                	li	s4,0
        if (strcmp(args[i],">")==0){
  98:	00001a97          	auipc	s5,0x1
  9c:	e38a8a93          	addi	s5,s5,-456 # ed0 <malloc+0xea>
  a0:	a081                	j	e0 <redirection+0x6c>
            x=1;
            if (args[i + 1] == 0) {
                printf("Usage: > filename\n");
  a2:	00001517          	auipc	a0,0x1
  a6:	e3650513          	addi	a0,a0,-458 # ed8 <malloc+0xf2>
  aa:	00001097          	auipc	ra,0x1
  ae:	c84080e7          	jalr	-892(ra) # d2e <printf>
                exit(0);
  b2:	4501                	li	a0,0
  b4:	00001097          	auipc	ra,0x1
  b8:	900080e7          	jalr	-1792(ra) # 9b4 <exit>
            }
            int fd1=open(args[i+1], O_WRONLY | O_CREATE | O_TRUNC );
            if (fd1<0){
                printf("Cannot open %s for writing\n",args[i+1]);
  bc:	608c                	ld	a1,0(s1)
  be:	00001517          	auipc	a0,0x1
  c2:	e3250513          	addi	a0,a0,-462 # ef0 <malloc+0x10a>
  c6:	00001097          	auipc	ra,0x1
  ca:	c68080e7          	jalr	-920(ra) # d2e <printf>
                exit(0);
  ce:	4501                	li	a0,0
  d0:	00001097          	auipc	ra,0x1
  d4:	8e4080e7          	jalr	-1820(ra) # 9b4 <exit>
    for (int i=0; args[i]!=0;i++){
  d8:	04a1                	addi	s1,s1,8
  da:	ff84b503          	ld	a0,-8(s1)
  de:	c539                	beqz	a0,12c <redirection+0xb8>
        if (strcmp(args[i],">")==0){
  e0:	85d6                	mv	a1,s5
  e2:	00000097          	auipc	ra,0x0
  e6:	682080e7          	jalr	1666(ra) # 764 <strcmp>
  ea:	f57d                	bnez	a0,d8 <redirection+0x64>
            if (args[i + 1] == 0) {
  ec:	6088                	ld	a0,0(s1)
  ee:	d955                	beqz	a0,a2 <redirection+0x2e>
            int fd1=open(args[i+1], O_WRONLY | O_CREATE | O_TRUNC );
  f0:	60100593          	li	a1,1537
  f4:	00001097          	auipc	ra,0x1
  f8:	900080e7          	jalr	-1792(ra) # 9f4 <open>
  fc:	89aa                	mv	s3,a0
            if (fd1<0){
  fe:	fa054fe3          	bltz	a0,bc <redirection+0x48>
            }
            close(1);
 102:	4505                	li	a0,1
 104:	00001097          	auipc	ra,0x1
 108:	8d8080e7          	jalr	-1832(ra) # 9dc <close>
            dup(fd1);
 10c:	854e                	mv	a0,s3
 10e:	00001097          	auipc	ra,0x1
 112:	91e080e7          	jalr	-1762(ra) # a2c <dup>
            close(fd1);
 116:	854e                	mv	a0,s3
 118:	00001097          	auipc	ra,0x1
 11c:	8c4080e7          	jalr	-1852(ra) # 9dc <close>
            args[i]=0;
 120:	fe04bc23          	sd	zero,-8(s1)
            args[i+1]=0;
 124:	0004b023          	sd	zero,0(s1)
            x=1;
 128:	4a05                	li	s4,1
 12a:	b77d                	j	d8 <redirection+0x64>
           
            
        } 
    }     
    for (int i=0; args[i]!=0;i++){    
 12c:	000b3503          	ld	a0,0(s6)
 130:	c145                	beqz	a0,1d0 <redirection+0x15c>
        if(strcmp(args[i],"<")==0){
 132:	00001a97          	auipc	s5,0x1
 136:	ddea8a93          	addi	s5,s5,-546 # f10 <malloc+0x12a>
            }
            close(0);
            dup(fd);
            close(fd);

            if (x==1){
 13a:	4b05                	li	s6,1
 13c:	a099                	j	182 <redirection+0x10e>
                printf("Usage: > filename\n");
 13e:	00001517          	auipc	a0,0x1
 142:	d9a50513          	addi	a0,a0,-614 # ed8 <malloc+0xf2>
 146:	00001097          	auipc	ra,0x1
 14a:	be8080e7          	jalr	-1048(ra) # d2e <printf>
                exit(0);
 14e:	4501                	li	a0,0
 150:	00001097          	auipc	ra,0x1
 154:	864080e7          	jalr	-1948(ra) # 9b4 <exit>
                printf("Cannot open %s for reading\n",args[i+1]);
 158:	00093583          	ld	a1,0(s2)
 15c:	00001517          	auipc	a0,0x1
 160:	dbc50513          	addi	a0,a0,-580 # f18 <malloc+0x132>
 164:	00001097          	auipc	ra,0x1
 168:	bca080e7          	jalr	-1078(ra) # d2e <printf>
                exit(0);
 16c:	4501                	li	a0,0
 16e:	00001097          	auipc	ra,0x1
 172:	846080e7          	jalr	-1978(ra) # 9b4 <exit>
                args[i]=0;     
 176:	fe093c23          	sd	zero,-8(s2)
    for (int i=0; args[i]!=0;i++){    
 17a:	0921                	addi	s2,s2,8
 17c:	ff893503          	ld	a0,-8(s2)
 180:	c921                	beqz	a0,1d0 <redirection+0x15c>
        if(strcmp(args[i],"<")==0){
 182:	85d6                	mv	a1,s5
 184:	00000097          	auipc	ra,0x0
 188:	5e0080e7          	jalr	1504(ra) # 764 <strcmp>
 18c:	f57d                	bnez	a0,17a <redirection+0x106>
            if (args[i + 1] == 0) {
 18e:	00093503          	ld	a0,0(s2)
 192:	d555                	beqz	a0,13e <redirection+0xca>
            int fd=open(args[i+1],O_RDONLY);
 194:	4581                	li	a1,0
 196:	00001097          	auipc	ra,0x1
 19a:	85e080e7          	jalr	-1954(ra) # 9f4 <open>
 19e:	84aa                	mv	s1,a0
            if (fd<0){
 1a0:	fa054ce3          	bltz	a0,158 <redirection+0xe4>
            close(0);
 1a4:	4501                	li	a0,0
 1a6:	00001097          	auipc	ra,0x1
 1aa:	836080e7          	jalr	-1994(ra) # 9dc <close>
            dup(fd);
 1ae:	8526                	mv	a0,s1
 1b0:	00001097          	auipc	ra,0x1
 1b4:	87c080e7          	jalr	-1924(ra) # a2c <dup>
            close(fd);
 1b8:	8526                	mv	a0,s1
 1ba:	00001097          	auipc	ra,0x1
 1be:	822080e7          	jalr	-2014(ra) # 9dc <close>
            if (x==1){
 1c2:	fb6a0ae3          	beq	s4,s6,176 <redirection+0x102>
            }else{
                args[i]=0;
 1c6:	fe093c23          	sd	zero,-8(s2)
                args[i+1]=0;
 1ca:	00093023          	sd	zero,0(s2)
 1ce:	b775                	j	17a <redirection+0x106>
            }
        }
        

    }     
}
 1d0:	70e2                	ld	ra,56(sp)
 1d2:	7442                	ld	s0,48(sp)
 1d4:	74a2                	ld	s1,40(sp)
 1d6:	7902                	ld	s2,32(sp)
 1d8:	69e2                	ld	s3,24(sp)
 1da:	6a42                	ld	s4,16(sp)
 1dc:	6aa2                	ld	s5,8(sp)
 1de:	6b02                	ld	s6,0(sp)
 1e0:	6121                	addi	sp,sp,64
 1e2:	8082                	ret

00000000000001e4 <executeCommand>:





void executeCommand(char *args[]){
 1e4:	1101                	addi	sp,sp,-32
 1e6:	ec06                	sd	ra,24(sp)
 1e8:	e822                	sd	s0,16(sp)
 1ea:	e426                	sd	s1,8(sp)
 1ec:	1000                	addi	s0,sp,32
 1ee:	84aa                	mv	s1,a0
    int pid = fork();
 1f0:	00000097          	auipc	ra,0x0
 1f4:	7bc080e7          	jalr	1980(ra) # 9ac <fork>
    if (pid < 0) {
 1f8:	00054d63          	bltz	a0,212 <executeCommand+0x2e>
        printf("Fork failed\n");
    } else if (pid == 0) {
 1fc:	c505                	beqz	a0,224 <executeCommand+0x40>
        // If exec fails, print an error message
        printf("Command not found: %s\n", args[0]);
        exit(0);
    } else {
        // This is the parent process
        wait(0);
 1fe:	4501                	li	a0,0
 200:	00000097          	auipc	ra,0x0
 204:	7bc080e7          	jalr	1980(ra) # 9bc <wait>


    }
}
 208:	60e2                	ld	ra,24(sp)
 20a:	6442                	ld	s0,16(sp)
 20c:	64a2                	ld	s1,8(sp)
 20e:	6105                	addi	sp,sp,32
 210:	8082                	ret
        printf("Fork failed\n");
 212:	00001517          	auipc	a0,0x1
 216:	d2650513          	addi	a0,a0,-730 # f38 <malloc+0x152>
 21a:	00001097          	auipc	ra,0x1
 21e:	b14080e7          	jalr	-1260(ra) # d2e <printf>
 222:	b7dd                	j	208 <executeCommand+0x24>
        redirection(args);
 224:	8526                	mv	a0,s1
 226:	00000097          	auipc	ra,0x0
 22a:	e4e080e7          	jalr	-434(ra) # 74 <redirection>
        exec(args[0], args);
 22e:	85a6                	mv	a1,s1
 230:	6088                	ld	a0,0(s1)
 232:	00000097          	auipc	ra,0x0
 236:	7ba080e7          	jalr	1978(ra) # 9ec <exec>
        printf("Command not found: %s\n", args[0]);
 23a:	608c                	ld	a1,0(s1)
 23c:	00001517          	auipc	a0,0x1
 240:	d0c50513          	addi	a0,a0,-756 # f48 <malloc+0x162>
 244:	00001097          	auipc	ra,0x1
 248:	aea080e7          	jalr	-1302(ra) # d2e <printf>
        exit(0);
 24c:	4501                	li	a0,0
 24e:	00000097          	auipc	ra,0x0
 252:	766080e7          	jalr	1894(ra) # 9b4 <exit>

0000000000000256 <createPipeDesc>:
    int index[2];
} PipeDescriptor;



void createPipeDesc(PipeDescriptor *pipeDesc){
 256:	1141                	addi	sp,sp,-16
 258:	e406                	sd	ra,8(sp)
 25a:	e022                	sd	s0,0(sp)
 25c:	0800                	addi	s0,sp,16
    if (pipe(pipeDesc->pipe_fds)==-1){
 25e:	00000097          	auipc	ra,0x0
 262:	766080e7          	jalr	1894(ra) # 9c4 <pipe>
 266:	57fd                	li	a5,-1
 268:	00f50663          	beq	a0,a5,274 <createPipeDesc+0x1e>
        printf("Pipe creation failed");
        exit(1);
    }
}
 26c:	60a2                	ld	ra,8(sp)
 26e:	6402                	ld	s0,0(sp)
 270:	0141                	addi	sp,sp,16
 272:	8082                	ret
        printf("Pipe creation failed");
 274:	00001517          	auipc	a0,0x1
 278:	cec50513          	addi	a0,a0,-788 # f60 <malloc+0x17a>
 27c:	00001097          	auipc	ra,0x1
 280:	ab2080e7          	jalr	-1358(ra) # d2e <printf>
        exit(1);
 284:	4505                	li	a0,1
 286:	00000097          	auipc	ra,0x0
 28a:	72e080e7          	jalr	1838(ra) # 9b4 <exit>

000000000000028e <closePipe>:

void closePipe(PipeDescriptor *pipeDesc){
 28e:	1101                	addi	sp,sp,-32
 290:	ec06                	sd	ra,24(sp)
 292:	e822                	sd	s0,16(sp)
 294:	e426                	sd	s1,8(sp)
 296:	1000                	addi	s0,sp,32
 298:	84aa                	mv	s1,a0
    close(pipeDesc->pipe_fds[0]);
 29a:	4108                	lw	a0,0(a0)
 29c:	00000097          	auipc	ra,0x0
 2a0:	740080e7          	jalr	1856(ra) # 9dc <close>
    close(pipeDesc->pipe_fds[1]);
 2a4:	40c8                	lw	a0,4(s1)
 2a6:	00000097          	auipc	ra,0x0
 2aa:	736080e7          	jalr	1846(ra) # 9dc <close>
}
 2ae:	60e2                	ld	ra,24(sp)
 2b0:	6442                	ld	s0,16(sp)
 2b2:	64a2                	ld	s1,8(sp)
 2b4:	6105                	addi	sp,sp,32
 2b6:	8082                	ret

00000000000002b8 <segmentHandler>:



void segmentHandler(char *args[], int num_args, int pipePosition[], int pipesFound) {
 2b8:	715d                	addi	sp,sp,-80
 2ba:	e486                	sd	ra,72(sp)
 2bc:	e0a2                	sd	s0,64(sp)
 2be:	fc26                	sd	s1,56(sp)
 2c0:	f84a                	sd	s2,48(sp)
 2c2:	f44e                	sd	s3,40(sp)
 2c4:	0880                	addi	s0,sp,80
 2c6:	89aa                	mv	s3,a0
 2c8:	84b2                	mv	s1,a2
 2ca:	8936                	mv	s2,a3
    PipeDescriptor pipeDesc;
    createPipeDesc(&pipeDesc);
 2cc:	fb040513          	addi	a0,s0,-80
 2d0:	00000097          	auipc	ra,0x0
 2d4:	f86080e7          	jalr	-122(ra) # 256 <createPipeDesc>
    int pid1, pid2;
    pipeDesc.index[0] = pipePosition[0]+1;
 2d8:	409c                	lw	a5,0(s1)
 2da:	2785                	addiw	a5,a5,1
 2dc:	fcf42223          	sw	a5,-60(s0)


    pid1 = fork();
 2e0:	00000097          	auipc	ra,0x0
 2e4:	6cc080e7          	jalr	1740(ra) # 9ac <fork>
    if (pid1 == 0) {
 2e8:	c911                	beqz	a0,2fc <segmentHandler+0x44>
        // Execute the first command segment
        exec(args[0], args);
        // If exec fails, print an error message
        printf("Execution failed");
        exit(0);
    } else if (pid1 > 0) {
 2ea:	06a04463          	bgtz	a0,352 <segmentHandler+0x9a>
            // If no pipes, wait for the first child to finish
            wait(0);
        }
    }
    // Return to the main while loop after handling pipes
}
 2ee:	60a6                	ld	ra,72(sp)
 2f0:	6406                	ld	s0,64(sp)
 2f2:	74e2                	ld	s1,56(sp)
 2f4:	7942                	ld	s2,48(sp)
 2f6:	79a2                	ld	s3,40(sp)
 2f8:	6161                	addi	sp,sp,80
 2fa:	8082                	ret
        close(pipeDesc.pipe_fds[0]);
 2fc:	fb042503          	lw	a0,-80(s0)
 300:	00000097          	auipc	ra,0x0
 304:	6dc080e7          	jalr	1756(ra) # 9dc <close>
        close(1);
 308:	4505                	li	a0,1
 30a:	00000097          	auipc	ra,0x0
 30e:	6d2080e7          	jalr	1746(ra) # 9dc <close>
        dup(pipeDesc.pipe_fds[1]);
 312:	fb442503          	lw	a0,-76(s0)
 316:	00000097          	auipc	ra,0x0
 31a:	716080e7          	jalr	1814(ra) # a2c <dup>
        close(pipeDesc.pipe_fds[1]);
 31e:	fb442503          	lw	a0,-76(s0)
 322:	00000097          	auipc	ra,0x0
 326:	6ba080e7          	jalr	1722(ra) # 9dc <close>
        exec(args[0], args);
 32a:	85ce                	mv	a1,s3
 32c:	0009b503          	ld	a0,0(s3)
 330:	00000097          	auipc	ra,0x0
 334:	6bc080e7          	jalr	1724(ra) # 9ec <exec>
        printf("Execution failed");
 338:	00001517          	auipc	a0,0x1
 33c:	c4050513          	addi	a0,a0,-960 # f78 <malloc+0x192>
 340:	00001097          	auipc	ra,0x1
 344:	9ee080e7          	jalr	-1554(ra) # d2e <printf>
        exit(0);
 348:	4501                	li	a0,0
 34a:	00000097          	auipc	ra,0x0
 34e:	66a080e7          	jalr	1642(ra) # 9b4 <exit>
        close(pipeDesc.pipe_fds[1]); // Close write end in the parent
 352:	fb442503          	lw	a0,-76(s0)
 356:	00000097          	auipc	ra,0x0
 35a:	686080e7          	jalr	1670(ra) # 9dc <close>
        if (pipesFound > 0) {
 35e:	09205263          	blez	s2,3e2 <segmentHandler+0x12a>
            pid2 = fork();
 362:	00000097          	auipc	ra,0x0
 366:	64a080e7          	jalr	1610(ra) # 9ac <fork>
            if (pid2 == 0) {
 36a:	cd11                	beqz	a0,386 <segmentHandler+0xce>
            } else if (pid2 > 0) {
 36c:	f8a051e3          	blez	a0,2ee <segmentHandler+0x36>
                wait(0);
 370:	4501                	li	a0,0
 372:	00000097          	auipc	ra,0x0
 376:	64a080e7          	jalr	1610(ra) # 9bc <wait>
                wait(0);
 37a:	4501                	li	a0,0
 37c:	00000097          	auipc	ra,0x0
 380:	640080e7          	jalr	1600(ra) # 9bc <wait>
 384:	b7ad                	j	2ee <segmentHandler+0x36>
                close(pipeDesc.pipe_fds[1]);
 386:	fb442503          	lw	a0,-76(s0)
 38a:	00000097          	auipc	ra,0x0
 38e:	652080e7          	jalr	1618(ra) # 9dc <close>
                close(0);
 392:	4501                	li	a0,0
 394:	00000097          	auipc	ra,0x0
 398:	648080e7          	jalr	1608(ra) # 9dc <close>
                dup(pipeDesc.pipe_fds[0]);
 39c:	fb042503          	lw	a0,-80(s0)
 3a0:	00000097          	auipc	ra,0x0
 3a4:	68c080e7          	jalr	1676(ra) # a2c <dup>
                close(pipeDesc.pipe_fds[0]);
 3a8:	fb042503          	lw	a0,-80(s0)
 3ac:	00000097          	auipc	ra,0x0
 3b0:	630080e7          	jalr	1584(ra) # 9dc <close>
                exec(args[pipeDesc.index[0]], args + pipeDesc.index[0]);
 3b4:	fc442783          	lw	a5,-60(s0)
 3b8:	078e                	slli	a5,a5,0x3
 3ba:	00f985b3          	add	a1,s3,a5
 3be:	6188                	ld	a0,0(a1)
 3c0:	00000097          	auipc	ra,0x0
 3c4:	62c080e7          	jalr	1580(ra) # 9ec <exec>
                printf("Execution failure");
 3c8:	00001517          	auipc	a0,0x1
 3cc:	bc850513          	addi	a0,a0,-1080 # f90 <malloc+0x1aa>
 3d0:	00001097          	auipc	ra,0x1
 3d4:	95e080e7          	jalr	-1698(ra) # d2e <printf>
                exit(1);
 3d8:	4505                	li	a0,1
 3da:	00000097          	auipc	ra,0x0
 3de:	5da080e7          	jalr	1498(ra) # 9b4 <exit>
            wait(0);
 3e2:	4501                	li	a0,0
 3e4:	00000097          	auipc	ra,0x0
 3e8:	5d8080e7          	jalr	1496(ra) # 9bc <wait>
}
 3ec:	b709                	j	2ee <segmentHandler+0x36>

00000000000003ee <multiElementPipelineHandler>:

void multiElementPipelineHandler(char *args[], int num_args, int pipePosition[], int pipesFound) {
 3ee:	715d                	addi	sp,sp,-80
 3f0:	e486                	sd	ra,72(sp)
 3f2:	e0a2                	sd	s0,64(sp)
 3f4:	fc26                	sd	s1,56(sp)
 3f6:	f84a                	sd	s2,48(sp)
 3f8:	f44e                	sd	s3,40(sp)
 3fa:	0880                	addi	s0,sp,80
 3fc:	89aa                	mv	s3,a0
 3fe:	84b2                	mv	s1,a2
 400:	8936                	mv	s2,a3
    PipeDescriptor pipeDesc;
    createPipeDesc(&pipeDesc);
 402:	fb040513          	addi	a0,s0,-80
 406:	00000097          	auipc	ra,0x0
 40a:	e50080e7          	jalr	-432(ra) # 256 <createPipeDesc>
    pipeDesc.index[0] = pipePosition[0]+1;
 40e:	409c                	lw	a5,0(s1)
 410:	2785                	addiw	a5,a5,1
 412:	fcf42223          	sw	a5,-60(s0)
    pipeDesc.index[1] = pipePosition[1]+1;
 416:	40dc                	lw	a5,4(s1)
 418:	2785                	addiw	a5,a5,1
 41a:	fcf42423          	sw	a5,-56(s0)
   
    int pid1, pid2, pid3;
    pid1 = fork();
 41e:	00000097          	auipc	ra,0x0
 422:	58e080e7          	jalr	1422(ra) # 9ac <fork>
    if (pid1 == 0) {
 426:	c911                	beqz	a0,43a <multiElementPipelineHandler+0x4c>
        // Execute the first command segment
        exec(args[0], args);
        // If exec fails, print an error message
        printf("Execution failed");
        exit(0);
    } else if (pid1 > 0) {
 428:	06a04463          	bgtz	a0,490 <multiElementPipelineHandler+0xa2>
                wait(0);
            }
        }
    }
    // Return to the main while loop after handling pipes
}
 42c:	60a6                	ld	ra,72(sp)
 42e:	6406                	ld	s0,64(sp)
 430:	74e2                	ld	s1,56(sp)
 432:	7942                	ld	s2,48(sp)
 434:	79a2                	ld	s3,40(sp)
 436:	6161                	addi	sp,sp,80
 438:	8082                	ret
        close(pipeDesc.pipe_fds[0]);
 43a:	fb042503          	lw	a0,-80(s0)
 43e:	00000097          	auipc	ra,0x0
 442:	59e080e7          	jalr	1438(ra) # 9dc <close>
        close(1);
 446:	4505                	li	a0,1
 448:	00000097          	auipc	ra,0x0
 44c:	594080e7          	jalr	1428(ra) # 9dc <close>
        dup(pipeDesc.pipe_fds[1]);
 450:	fb442503          	lw	a0,-76(s0)
 454:	00000097          	auipc	ra,0x0
 458:	5d8080e7          	jalr	1496(ra) # a2c <dup>
        close(pipeDesc.pipe_fds[1]);
 45c:	fb442503          	lw	a0,-76(s0)
 460:	00000097          	auipc	ra,0x0
 464:	57c080e7          	jalr	1404(ra) # 9dc <close>
        exec(args[0], args);
 468:	85ce                	mv	a1,s3
 46a:	0009b503          	ld	a0,0(s3)
 46e:	00000097          	auipc	ra,0x0
 472:	57e080e7          	jalr	1406(ra) # 9ec <exec>
        printf("Execution failed");
 476:	00001517          	auipc	a0,0x1
 47a:	b0250513          	addi	a0,a0,-1278 # f78 <malloc+0x192>
 47e:	00001097          	auipc	ra,0x1
 482:	8b0080e7          	jalr	-1872(ra) # d2e <printf>
        exit(0);
 486:	4501                	li	a0,0
 488:	00000097          	auipc	ra,0x0
 48c:	52c080e7          	jalr	1324(ra) # 9b4 <exit>
        close(pipeDesc.pipe_fds[1]); // Close write end in the parent
 490:	fb442503          	lw	a0,-76(s0)
 494:	00000097          	auipc	ra,0x0
 498:	548080e7          	jalr	1352(ra) # 9dc <close>
        if (pipesFound > 0) {
 49c:	f92058e3          	blez	s2,42c <multiElementPipelineHandler+0x3e>
            pid2 = fork();
 4a0:	00000097          	auipc	ra,0x0
 4a4:	50c080e7          	jalr	1292(ra) # 9ac <fork>
            if (pid2 == 0) {
 4a8:	c131                	beqz	a0,4ec <multiElementPipelineHandler+0xfe>
            } else if (pid2 > 0) {
 4aa:	0ea05c63          	blez	a0,5a2 <multiElementPipelineHandler+0x1b4>
                wait(0);
 4ae:	4501                	li	a0,0
 4b0:	00000097          	auipc	ra,0x0
 4b4:	50c080e7          	jalr	1292(ra) # 9bc <wait>
                if (pipesFound > 1) {
 4b8:	4785                	li	a5,1
 4ba:	f727d9e3          	bge	a5,s2,42c <multiElementPipelineHandler+0x3e>
                    pid3 = fork();
 4be:	00000097          	auipc	ra,0x0
 4c2:	4ee080e7          	jalr	1262(ra) # 9ac <fork>
                    if (pid3 == 0) {
 4c6:	c141                	beqz	a0,546 <multiElementPipelineHandler+0x158>
                    } else if (pid3 > 0) {
 4c8:	f6a052e3          	blez	a0,42c <multiElementPipelineHandler+0x3e>
                        wait(0);
 4cc:	4501                	li	a0,0
 4ce:	00000097          	auipc	ra,0x0
 4d2:	4ee080e7          	jalr	1262(ra) # 9bc <wait>
                        wait(0);
 4d6:	4501                	li	a0,0
 4d8:	00000097          	auipc	ra,0x0
 4dc:	4e4080e7          	jalr	1252(ra) # 9bc <wait>
                        wait(0);
 4e0:	4501                	li	a0,0
 4e2:	00000097          	auipc	ra,0x0
 4e6:	4da080e7          	jalr	1242(ra) # 9bc <wait>
 4ea:	b789                	j	42c <multiElementPipelineHandler+0x3e>
                close(pipeDesc.pipe_fds[1]);
 4ec:	fb442503          	lw	a0,-76(s0)
 4f0:	00000097          	auipc	ra,0x0
 4f4:	4ec080e7          	jalr	1260(ra) # 9dc <close>
                close(0);
 4f8:	4501                	li	a0,0
 4fa:	00000097          	auipc	ra,0x0
 4fe:	4e2080e7          	jalr	1250(ra) # 9dc <close>
                dup(pipeDesc.pipe_fds[0]);
 502:	fb042503          	lw	a0,-80(s0)
 506:	00000097          	auipc	ra,0x0
 50a:	526080e7          	jalr	1318(ra) # a2c <dup>
                close(pipeDesc.pipe_fds[0]);
 50e:	fb042503          	lw	a0,-80(s0)
 512:	00000097          	auipc	ra,0x0
 516:	4ca080e7          	jalr	1226(ra) # 9dc <close>
                exec(args[pipeDesc.index[0]], args + pipeDesc.index[0] );
 51a:	fc442583          	lw	a1,-60(s0)
 51e:	058e                	slli	a1,a1,0x3
 520:	95ce                	add	a1,a1,s3
 522:	6188                	ld	a0,0(a1)
 524:	00000097          	auipc	ra,0x0
 528:	4c8080e7          	jalr	1224(ra) # 9ec <exec>
                printf("Execution failure");
 52c:	00001517          	auipc	a0,0x1
 530:	a6450513          	addi	a0,a0,-1436 # f90 <malloc+0x1aa>
 534:	00000097          	auipc	ra,0x0
 538:	7fa080e7          	jalr	2042(ra) # d2e <printf>
                exit(1);
 53c:	4505                	li	a0,1
 53e:	00000097          	auipc	ra,0x0
 542:	476080e7          	jalr	1142(ra) # 9b4 <exit>
                        close(pipeDesc.pipe_fds[2]);
 546:	fb842503          	lw	a0,-72(s0)
 54a:	00000097          	auipc	ra,0x0
 54e:	492080e7          	jalr	1170(ra) # 9dc <close>
                        close(0);
 552:	4501                	li	a0,0
 554:	00000097          	auipc	ra,0x0
 558:	488080e7          	jalr	1160(ra) # 9dc <close>
                        dup(pipeDesc.pipe_fds[1]);
 55c:	fb442503          	lw	a0,-76(s0)
 560:	00000097          	auipc	ra,0x0
 564:	4cc080e7          	jalr	1228(ra) # a2c <dup>
                        close(pipeDesc.pipe_fds[1]);
 568:	fb442503          	lw	a0,-76(s0)
 56c:	00000097          	auipc	ra,0x0
 570:	470080e7          	jalr	1136(ra) # 9dc <close>
                        exec(args[pipeDesc.index[1] ], args + pipeDesc.index[1]);
 574:	fc842783          	lw	a5,-56(s0)
 578:	078e                	slli	a5,a5,0x3
 57a:	00f985b3          	add	a1,s3,a5
 57e:	6188                	ld	a0,0(a1)
 580:	00000097          	auipc	ra,0x0
 584:	46c080e7          	jalr	1132(ra) # 9ec <exec>
                        printf("Execution failure");
 588:	00001517          	auipc	a0,0x1
 58c:	a0850513          	addi	a0,a0,-1528 # f90 <malloc+0x1aa>
 590:	00000097          	auipc	ra,0x0
 594:	79e080e7          	jalr	1950(ra) # d2e <printf>
                        exit(1);
 598:	4505                	li	a0,1
 59a:	00000097          	auipc	ra,0x0
 59e:	41a080e7          	jalr	1050(ra) # 9b4 <exit>
                wait(0);
 5a2:	4501                	li	a0,0
 5a4:	00000097          	auipc	ra,0x0
 5a8:	418080e7          	jalr	1048(ra) # 9bc <wait>
}
 5ac:	b541                	j	42c <multiElementPipelineHandler+0x3e>

00000000000005ae <containsPipe>:
    

int containsPipe(char *args[], int num_args) {
 5ae:	715d                	addi	sp,sp,-80
 5b0:	e486                	sd	ra,72(sp)
 5b2:	e0a2                	sd	s0,64(sp)
 5b4:	fc26                	sd	s1,56(sp)
 5b6:	f84a                	sd	s2,48(sp)
 5b8:	f44e                	sd	s3,40(sp)
 5ba:	f052                	sd	s4,32(sp)
 5bc:	ec56                	sd	s5,24(sp)
 5be:	e85a                	sd	s6,16(sp)
 5c0:	0880                	addi	s0,sp,80
    int pipePosition[3];
    int pipesFound = 0;

    for (int i = 0; i < num_args; i++) {
 5c2:	08b05763          	blez	a1,650 <containsPipe+0xa2>
 5c6:	8b2a                	mv	s6,a0
 5c8:	8a2e                	mv	s4,a1
 5ca:	892a                	mv	s2,a0
 5cc:	4481                	li	s1,0
    int pipesFound = 0;
 5ce:	4981                	li	s3,0
        if (strcmp(args[i], "|") == 0) {
 5d0:	00001a97          	auipc	s5,0x1
 5d4:	9d8a8a93          	addi	s5,s5,-1576 # fa8 <malloc+0x1c2>
 5d8:	a029                	j	5e2 <containsPipe+0x34>
    for (int i = 0; i < num_args; i++) {
 5da:	2485                	addiw	s1,s1,1
 5dc:	0921                	addi	s2,s2,8
 5de:	029a0563          	beq	s4,s1,608 <containsPipe+0x5a>
        if (strcmp(args[i], "|") == 0) {
 5e2:	85d6                	mv	a1,s5
 5e4:	00093503          	ld	a0,0(s2)
 5e8:	00000097          	auipc	ra,0x0
 5ec:	17c080e7          	jalr	380(ra) # 764 <strcmp>
 5f0:	f56d                	bnez	a0,5da <containsPipe+0x2c>
            args[i] = 0;
 5f2:	00093023          	sd	zero,0(s2)
            pipePosition[pipesFound++] = i;
 5f6:	00299793          	slli	a5,s3,0x2
 5fa:	fc078793          	addi	a5,a5,-64
 5fe:	97a2                	add	a5,a5,s0
 600:	fe97a823          	sw	s1,-16(a5)
 604:	2985                	addiw	s3,s3,1
 606:	bfd1                	j	5da <containsPipe+0x2c>
        }
    }

    if (pipesFound > 0) {
 608:	05305663          	blez	s3,654 <containsPipe+0xa6>
        if (pipesFound == 1) {
 60c:	4785                	li	a5,1
 60e:	02f98763          	beq	s3,a5,63c <containsPipe+0x8e>
            // Single-element pipeline
            segmentHandler(args, num_args, pipePosition, pipesFound);
        } else {
            // Multi-element pipeline
            multiElementPipelineHandler(args, num_args, pipePosition, pipesFound);
 612:	86ce                	mv	a3,s3
 614:	fb040613          	addi	a2,s0,-80
 618:	85a6                	mv	a1,s1
 61a:	855a                	mv	a0,s6
 61c:	00000097          	auipc	ra,0x0
 620:	dd2080e7          	jalr	-558(ra) # 3ee <multiElementPipelineHandler>
        }
        return 1;
 624:	4985                	li	s3,1
    } else {
        // No pipes found
        return 0;
    }
}
 626:	854e                	mv	a0,s3
 628:	60a6                	ld	ra,72(sp)
 62a:	6406                	ld	s0,64(sp)
 62c:	74e2                	ld	s1,56(sp)
 62e:	7942                	ld	s2,48(sp)
 630:	79a2                	ld	s3,40(sp)
 632:	7a02                	ld	s4,32(sp)
 634:	6ae2                	ld	s5,24(sp)
 636:	6b42                	ld	s6,16(sp)
 638:	6161                	addi	sp,sp,80
 63a:	8082                	ret
            segmentHandler(args, num_args, pipePosition, pipesFound);
 63c:	4685                	li	a3,1
 63e:	fb040613          	addi	a2,s0,-80
 642:	85a6                	mv	a1,s1
 644:	855a                	mv	a0,s6
 646:	00000097          	auipc	ra,0x0
 64a:	c72080e7          	jalr	-910(ra) # 2b8 <segmentHandler>
 64e:	bfe1                	j	626 <containsPipe+0x78>
        return 0;
 650:	4981                	li	s3,0
 652:	bfd1                	j	626 <containsPipe+0x78>
 654:	4981                	li	s3,0
 656:	bfc1                	j	626 <containsPipe+0x78>

0000000000000658 <main>:


int main(int argc, char *argv[]) {
 658:	7165                	addi	sp,sp,-400
 65a:	e706                	sd	ra,392(sp)
 65c:	e322                	sd	s0,384(sp)
 65e:	fea6                	sd	s1,376(sp)
 660:	faca                	sd	s2,368(sp)
 662:	f6ce                	sd	s3,360(sp)
 664:	f2d2                	sd	s4,352(sp)
 666:	eed6                	sd	s5,344(sp)
 668:	eada                	sd	s6,336(sp)
 66a:	0b00                	addi	s0,sp,400
    char buf[MAX_CMD_LEN];
    char *args[MAX_ARGS];
    while (1) {
        const char* Prompt=">>> ";
        write(1,Prompt,strlen(Prompt)); 
 66c:	00001917          	auipc	s2,0x1
 670:	94490913          	addi	s2,s2,-1724 # fb0 <malloc+0x1ca>
        // Tokenize the input command
        int num_args = tokenise(buf, args);
        
        if (num_args > 0) {
            // Check for built-in commands
            if (strcmp(args[0], "cd") == 0) {
 674:	00001997          	auipc	s3,0x1
 678:	94498993          	addi	s3,s3,-1724 # fb8 <malloc+0x1d2>
                if(num_args !=2){
 67c:	4a09                	li	s4,2
                    printf("Usage: cd <directory>\n");

                }else{
                    if (chdir(args[1])<0){
                        printf("cd: cannot change directory to %s\n",args[1]);
 67e:	00001b17          	auipc	s6,0x1
 682:	95ab0b13          	addi	s6,s6,-1702 # fd8 <malloc+0x1f2>
                    printf("Usage: cd <directory>\n");
 686:	00001a97          	auipc	s5,0x1
 68a:	93aa8a93          	addi	s5,s5,-1734 # fc0 <malloc+0x1da>
 68e:	a80d                	j	6c0 <main+0x68>
                    if (chdir(args[1])<0){
 690:	e7843503          	ld	a0,-392(s0)
 694:	00000097          	auipc	ra,0x0
 698:	390080e7          	jalr	912(ra) # a24 <chdir>
 69c:	02055263          	bgez	a0,6c0 <main+0x68>
                        printf("cd: cannot change directory to %s\n",args[1]);
 6a0:	e7843583          	ld	a1,-392(s0)
 6a4:	855a                	mv	a0,s6
 6a6:	00000097          	auipc	ra,0x0
 6aa:	688080e7          	jalr	1672(ra) # d2e <printf>
 6ae:	a809                	j	6c0 <main+0x68>
                }    
                
            } else {
                // Fork a child process to execute the command

                if (containsPipe(args,num_args)==0){
 6b0:	85a6                	mv	a1,s1
 6b2:	e7040513          	addi	a0,s0,-400
 6b6:	00000097          	auipc	ra,0x0
 6ba:	ef8080e7          	jalr	-264(ra) # 5ae <containsPipe>
 6be:	c12d                	beqz	a0,720 <main+0xc8>
        write(1,Prompt,strlen(Prompt)); 
 6c0:	854a                	mv	a0,s2
 6c2:	00000097          	auipc	ra,0x0
 6c6:	0ce080e7          	jalr	206(ra) # 790 <strlen>
 6ca:	0005061b          	sext.w	a2,a0
 6ce:	85ca                	mv	a1,s2
 6d0:	4505                	li	a0,1
 6d2:	00000097          	auipc	ra,0x0
 6d6:	302080e7          	jalr	770(ra) # 9d4 <write>
        gets(buf, sizeof(buf));
 6da:	10000593          	li	a1,256
 6de:	ec040513          	addi	a0,s0,-320
 6e2:	00000097          	auipc	ra,0x0
 6e6:	11e080e7          	jalr	286(ra) # 800 <gets>
        int num_args = tokenise(buf, args);
 6ea:	e7040593          	addi	a1,s0,-400
 6ee:	ec040513          	addi	a0,s0,-320
 6f2:	00000097          	auipc	ra,0x0
 6f6:	90e080e7          	jalr	-1778(ra) # 0 <tokenise>
 6fa:	84aa                	mv	s1,a0
        if (num_args > 0) {
 6fc:	fca052e3          	blez	a0,6c0 <main+0x68>
            if (strcmp(args[0], "cd") == 0) {
 700:	85ce                	mv	a1,s3
 702:	e7043503          	ld	a0,-400(s0)
 706:	00000097          	auipc	ra,0x0
 70a:	05e080e7          	jalr	94(ra) # 764 <strcmp>
 70e:	f14d                	bnez	a0,6b0 <main+0x58>
                if(num_args !=2){
 710:	f94480e3          	beq	s1,s4,690 <main+0x38>
                    printf("Usage: cd <directory>\n");
 714:	8556                	mv	a0,s5
 716:	00000097          	auipc	ra,0x0
 71a:	618080e7          	jalr	1560(ra) # d2e <printf>
 71e:	b74d                	j	6c0 <main+0x68>
                    executeCommand(args);
 720:	e7040513          	addi	a0,s0,-400
 724:	00000097          	auipc	ra,0x0
 728:	ac0080e7          	jalr	-1344(ra) # 1e4 <executeCommand>
 72c:	bf51                	j	6c0 <main+0x68>

000000000000072e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 72e:	1141                	addi	sp,sp,-16
 730:	e406                	sd	ra,8(sp)
 732:	e022                	sd	s0,0(sp)
 734:	0800                	addi	s0,sp,16
  extern int main();
  main();
 736:	00000097          	auipc	ra,0x0
 73a:	f22080e7          	jalr	-222(ra) # 658 <main>
  exit(0);
 73e:	4501                	li	a0,0
 740:	00000097          	auipc	ra,0x0
 744:	274080e7          	jalr	628(ra) # 9b4 <exit>

0000000000000748 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 748:	1141                	addi	sp,sp,-16
 74a:	e422                	sd	s0,8(sp)
 74c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 74e:	87aa                	mv	a5,a0
 750:	0585                	addi	a1,a1,1
 752:	0785                	addi	a5,a5,1
 754:	fff5c703          	lbu	a4,-1(a1)
 758:	fee78fa3          	sb	a4,-1(a5)
 75c:	fb75                	bnez	a4,750 <strcpy+0x8>
    ;
  return os;
}
 75e:	6422                	ld	s0,8(sp)
 760:	0141                	addi	sp,sp,16
 762:	8082                	ret

0000000000000764 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 764:	1141                	addi	sp,sp,-16
 766:	e422                	sd	s0,8(sp)
 768:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 76a:	00054783          	lbu	a5,0(a0)
 76e:	cb91                	beqz	a5,782 <strcmp+0x1e>
 770:	0005c703          	lbu	a4,0(a1)
 774:	00f71763          	bne	a4,a5,782 <strcmp+0x1e>
    p++, q++;
 778:	0505                	addi	a0,a0,1
 77a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 77c:	00054783          	lbu	a5,0(a0)
 780:	fbe5                	bnez	a5,770 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 782:	0005c503          	lbu	a0,0(a1)
}
 786:	40a7853b          	subw	a0,a5,a0
 78a:	6422                	ld	s0,8(sp)
 78c:	0141                	addi	sp,sp,16
 78e:	8082                	ret

0000000000000790 <strlen>:

uint
strlen(const char *s)
{
 790:	1141                	addi	sp,sp,-16
 792:	e422                	sd	s0,8(sp)
 794:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 796:	00054783          	lbu	a5,0(a0)
 79a:	cf91                	beqz	a5,7b6 <strlen+0x26>
 79c:	0505                	addi	a0,a0,1
 79e:	87aa                	mv	a5,a0
 7a0:	4685                	li	a3,1
 7a2:	9e89                	subw	a3,a3,a0
 7a4:	00f6853b          	addw	a0,a3,a5
 7a8:	0785                	addi	a5,a5,1
 7aa:	fff7c703          	lbu	a4,-1(a5)
 7ae:	fb7d                	bnez	a4,7a4 <strlen+0x14>
    ;
  return n;
}
 7b0:	6422                	ld	s0,8(sp)
 7b2:	0141                	addi	sp,sp,16
 7b4:	8082                	ret
  for(n = 0; s[n]; n++)
 7b6:	4501                	li	a0,0
 7b8:	bfe5                	j	7b0 <strlen+0x20>

00000000000007ba <memset>:

void*
memset(void *dst, int c, uint n)
{
 7ba:	1141                	addi	sp,sp,-16
 7bc:	e422                	sd	s0,8(sp)
 7be:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 7c0:	ca19                	beqz	a2,7d6 <memset+0x1c>
 7c2:	87aa                	mv	a5,a0
 7c4:	1602                	slli	a2,a2,0x20
 7c6:	9201                	srli	a2,a2,0x20
 7c8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 7cc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 7d0:	0785                	addi	a5,a5,1
 7d2:	fee79de3          	bne	a5,a4,7cc <memset+0x12>
  }
  return dst;
}
 7d6:	6422                	ld	s0,8(sp)
 7d8:	0141                	addi	sp,sp,16
 7da:	8082                	ret

00000000000007dc <strchr>:

char*
strchr(const char *s, char c)
{
 7dc:	1141                	addi	sp,sp,-16
 7de:	e422                	sd	s0,8(sp)
 7e0:	0800                	addi	s0,sp,16
  for(; *s; s++)
 7e2:	00054783          	lbu	a5,0(a0)
 7e6:	cb99                	beqz	a5,7fc <strchr+0x20>
    if(*s == c)
 7e8:	00f58763          	beq	a1,a5,7f6 <strchr+0x1a>
  for(; *s; s++)
 7ec:	0505                	addi	a0,a0,1
 7ee:	00054783          	lbu	a5,0(a0)
 7f2:	fbfd                	bnez	a5,7e8 <strchr+0xc>
      return (char*)s;
  return 0;
 7f4:	4501                	li	a0,0
}
 7f6:	6422                	ld	s0,8(sp)
 7f8:	0141                	addi	sp,sp,16
 7fa:	8082                	ret
  return 0;
 7fc:	4501                	li	a0,0
 7fe:	bfe5                	j	7f6 <strchr+0x1a>

0000000000000800 <gets>:

char*
gets(char *buf, int max)
{
 800:	711d                	addi	sp,sp,-96
 802:	ec86                	sd	ra,88(sp)
 804:	e8a2                	sd	s0,80(sp)
 806:	e4a6                	sd	s1,72(sp)
 808:	e0ca                	sd	s2,64(sp)
 80a:	fc4e                	sd	s3,56(sp)
 80c:	f852                	sd	s4,48(sp)
 80e:	f456                	sd	s5,40(sp)
 810:	f05a                	sd	s6,32(sp)
 812:	ec5e                	sd	s7,24(sp)
 814:	1080                	addi	s0,sp,96
 816:	8baa                	mv	s7,a0
 818:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 81a:	892a                	mv	s2,a0
 81c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 81e:	4aa9                	li	s5,10
 820:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 822:	89a6                	mv	s3,s1
 824:	2485                	addiw	s1,s1,1
 826:	0344d863          	bge	s1,s4,856 <gets+0x56>
    cc = read(0, &c, 1);
 82a:	4605                	li	a2,1
 82c:	faf40593          	addi	a1,s0,-81
 830:	4501                	li	a0,0
 832:	00000097          	auipc	ra,0x0
 836:	19a080e7          	jalr	410(ra) # 9cc <read>
    if(cc < 1)
 83a:	00a05e63          	blez	a0,856 <gets+0x56>
    buf[i++] = c;
 83e:	faf44783          	lbu	a5,-81(s0)
 842:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 846:	01578763          	beq	a5,s5,854 <gets+0x54>
 84a:	0905                	addi	s2,s2,1
 84c:	fd679be3          	bne	a5,s6,822 <gets+0x22>
  for(i=0; i+1 < max; ){
 850:	89a6                	mv	s3,s1
 852:	a011                	j	856 <gets+0x56>
 854:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 856:	99de                	add	s3,s3,s7
 858:	00098023          	sb	zero,0(s3)
  return buf;
}
 85c:	855e                	mv	a0,s7
 85e:	60e6                	ld	ra,88(sp)
 860:	6446                	ld	s0,80(sp)
 862:	64a6                	ld	s1,72(sp)
 864:	6906                	ld	s2,64(sp)
 866:	79e2                	ld	s3,56(sp)
 868:	7a42                	ld	s4,48(sp)
 86a:	7aa2                	ld	s5,40(sp)
 86c:	7b02                	ld	s6,32(sp)
 86e:	6be2                	ld	s7,24(sp)
 870:	6125                	addi	sp,sp,96
 872:	8082                	ret

0000000000000874 <stat>:

int
stat(const char *n, struct stat *st)
{
 874:	1101                	addi	sp,sp,-32
 876:	ec06                	sd	ra,24(sp)
 878:	e822                	sd	s0,16(sp)
 87a:	e426                	sd	s1,8(sp)
 87c:	e04a                	sd	s2,0(sp)
 87e:	1000                	addi	s0,sp,32
 880:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 882:	4581                	li	a1,0
 884:	00000097          	auipc	ra,0x0
 888:	170080e7          	jalr	368(ra) # 9f4 <open>
  if(fd < 0)
 88c:	02054563          	bltz	a0,8b6 <stat+0x42>
 890:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 892:	85ca                	mv	a1,s2
 894:	00000097          	auipc	ra,0x0
 898:	178080e7          	jalr	376(ra) # a0c <fstat>
 89c:	892a                	mv	s2,a0
  close(fd);
 89e:	8526                	mv	a0,s1
 8a0:	00000097          	auipc	ra,0x0
 8a4:	13c080e7          	jalr	316(ra) # 9dc <close>
  return r;
}
 8a8:	854a                	mv	a0,s2
 8aa:	60e2                	ld	ra,24(sp)
 8ac:	6442                	ld	s0,16(sp)
 8ae:	64a2                	ld	s1,8(sp)
 8b0:	6902                	ld	s2,0(sp)
 8b2:	6105                	addi	sp,sp,32
 8b4:	8082                	ret
    return -1;
 8b6:	597d                	li	s2,-1
 8b8:	bfc5                	j	8a8 <stat+0x34>

00000000000008ba <atoi>:

int
atoi(const char *s)
{
 8ba:	1141                	addi	sp,sp,-16
 8bc:	e422                	sd	s0,8(sp)
 8be:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 8c0:	00054683          	lbu	a3,0(a0)
 8c4:	fd06879b          	addiw	a5,a3,-48
 8c8:	0ff7f793          	zext.b	a5,a5
 8cc:	4625                	li	a2,9
 8ce:	02f66863          	bltu	a2,a5,8fe <atoi+0x44>
 8d2:	872a                	mv	a4,a0
  n = 0;
 8d4:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 8d6:	0705                	addi	a4,a4,1
 8d8:	0025179b          	slliw	a5,a0,0x2
 8dc:	9fa9                	addw	a5,a5,a0
 8de:	0017979b          	slliw	a5,a5,0x1
 8e2:	9fb5                	addw	a5,a5,a3
 8e4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 8e8:	00074683          	lbu	a3,0(a4)
 8ec:	fd06879b          	addiw	a5,a3,-48
 8f0:	0ff7f793          	zext.b	a5,a5
 8f4:	fef671e3          	bgeu	a2,a5,8d6 <atoi+0x1c>
  return n;
}
 8f8:	6422                	ld	s0,8(sp)
 8fa:	0141                	addi	sp,sp,16
 8fc:	8082                	ret
  n = 0;
 8fe:	4501                	li	a0,0
 900:	bfe5                	j	8f8 <atoi+0x3e>

0000000000000902 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 902:	1141                	addi	sp,sp,-16
 904:	e422                	sd	s0,8(sp)
 906:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 908:	02b57463          	bgeu	a0,a1,930 <memmove+0x2e>
    while(n-- > 0)
 90c:	00c05f63          	blez	a2,92a <memmove+0x28>
 910:	1602                	slli	a2,a2,0x20
 912:	9201                	srli	a2,a2,0x20
 914:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 918:	872a                	mv	a4,a0
      *dst++ = *src++;
 91a:	0585                	addi	a1,a1,1
 91c:	0705                	addi	a4,a4,1
 91e:	fff5c683          	lbu	a3,-1(a1)
 922:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 926:	fee79ae3          	bne	a5,a4,91a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 92a:	6422                	ld	s0,8(sp)
 92c:	0141                	addi	sp,sp,16
 92e:	8082                	ret
    dst += n;
 930:	00c50733          	add	a4,a0,a2
    src += n;
 934:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 936:	fec05ae3          	blez	a2,92a <memmove+0x28>
 93a:	fff6079b          	addiw	a5,a2,-1
 93e:	1782                	slli	a5,a5,0x20
 940:	9381                	srli	a5,a5,0x20
 942:	fff7c793          	not	a5,a5
 946:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 948:	15fd                	addi	a1,a1,-1
 94a:	177d                	addi	a4,a4,-1
 94c:	0005c683          	lbu	a3,0(a1)
 950:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 954:	fee79ae3          	bne	a5,a4,948 <memmove+0x46>
 958:	bfc9                	j	92a <memmove+0x28>

000000000000095a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 95a:	1141                	addi	sp,sp,-16
 95c:	e422                	sd	s0,8(sp)
 95e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 960:	ca05                	beqz	a2,990 <memcmp+0x36>
 962:	fff6069b          	addiw	a3,a2,-1
 966:	1682                	slli	a3,a3,0x20
 968:	9281                	srli	a3,a3,0x20
 96a:	0685                	addi	a3,a3,1
 96c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 96e:	00054783          	lbu	a5,0(a0)
 972:	0005c703          	lbu	a4,0(a1)
 976:	00e79863          	bne	a5,a4,986 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 97a:	0505                	addi	a0,a0,1
    p2++;
 97c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 97e:	fed518e3          	bne	a0,a3,96e <memcmp+0x14>
  }
  return 0;
 982:	4501                	li	a0,0
 984:	a019                	j	98a <memcmp+0x30>
      return *p1 - *p2;
 986:	40e7853b          	subw	a0,a5,a4
}
 98a:	6422                	ld	s0,8(sp)
 98c:	0141                	addi	sp,sp,16
 98e:	8082                	ret
  return 0;
 990:	4501                	li	a0,0
 992:	bfe5                	j	98a <memcmp+0x30>

0000000000000994 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 994:	1141                	addi	sp,sp,-16
 996:	e406                	sd	ra,8(sp)
 998:	e022                	sd	s0,0(sp)
 99a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 99c:	00000097          	auipc	ra,0x0
 9a0:	f66080e7          	jalr	-154(ra) # 902 <memmove>
}
 9a4:	60a2                	ld	ra,8(sp)
 9a6:	6402                	ld	s0,0(sp)
 9a8:	0141                	addi	sp,sp,16
 9aa:	8082                	ret

00000000000009ac <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 9ac:	4885                	li	a7,1
 ecall
 9ae:	00000073          	ecall
 ret
 9b2:	8082                	ret

00000000000009b4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 9b4:	4889                	li	a7,2
 ecall
 9b6:	00000073          	ecall
 ret
 9ba:	8082                	ret

00000000000009bc <wait>:
.global wait
wait:
 li a7, SYS_wait
 9bc:	488d                	li	a7,3
 ecall
 9be:	00000073          	ecall
 ret
 9c2:	8082                	ret

00000000000009c4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 9c4:	4891                	li	a7,4
 ecall
 9c6:	00000073          	ecall
 ret
 9ca:	8082                	ret

00000000000009cc <read>:
.global read
read:
 li a7, SYS_read
 9cc:	4895                	li	a7,5
 ecall
 9ce:	00000073          	ecall
 ret
 9d2:	8082                	ret

00000000000009d4 <write>:
.global write
write:
 li a7, SYS_write
 9d4:	48c1                	li	a7,16
 ecall
 9d6:	00000073          	ecall
 ret
 9da:	8082                	ret

00000000000009dc <close>:
.global close
close:
 li a7, SYS_close
 9dc:	48d5                	li	a7,21
 ecall
 9de:	00000073          	ecall
 ret
 9e2:	8082                	ret

00000000000009e4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 9e4:	4899                	li	a7,6
 ecall
 9e6:	00000073          	ecall
 ret
 9ea:	8082                	ret

00000000000009ec <exec>:
.global exec
exec:
 li a7, SYS_exec
 9ec:	489d                	li	a7,7
 ecall
 9ee:	00000073          	ecall
 ret
 9f2:	8082                	ret

00000000000009f4 <open>:
.global open
open:
 li a7, SYS_open
 9f4:	48bd                	li	a7,15
 ecall
 9f6:	00000073          	ecall
 ret
 9fa:	8082                	ret

00000000000009fc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 9fc:	48c5                	li	a7,17
 ecall
 9fe:	00000073          	ecall
 ret
 a02:	8082                	ret

0000000000000a04 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 a04:	48c9                	li	a7,18
 ecall
 a06:	00000073          	ecall
 ret
 a0a:	8082                	ret

0000000000000a0c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 a0c:	48a1                	li	a7,8
 ecall
 a0e:	00000073          	ecall
 ret
 a12:	8082                	ret

0000000000000a14 <link>:
.global link
link:
 li a7, SYS_link
 a14:	48cd                	li	a7,19
 ecall
 a16:	00000073          	ecall
 ret
 a1a:	8082                	ret

0000000000000a1c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 a1c:	48d1                	li	a7,20
 ecall
 a1e:	00000073          	ecall
 ret
 a22:	8082                	ret

0000000000000a24 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 a24:	48a5                	li	a7,9
 ecall
 a26:	00000073          	ecall
 ret
 a2a:	8082                	ret

0000000000000a2c <dup>:
.global dup
dup:
 li a7, SYS_dup
 a2c:	48a9                	li	a7,10
 ecall
 a2e:	00000073          	ecall
 ret
 a32:	8082                	ret

0000000000000a34 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 a34:	48ad                	li	a7,11
 ecall
 a36:	00000073          	ecall
 ret
 a3a:	8082                	ret

0000000000000a3c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 a3c:	48b1                	li	a7,12
 ecall
 a3e:	00000073          	ecall
 ret
 a42:	8082                	ret

0000000000000a44 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 a44:	48b5                	li	a7,13
 ecall
 a46:	00000073          	ecall
 ret
 a4a:	8082                	ret

0000000000000a4c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 a4c:	48b9                	li	a7,14
 ecall
 a4e:	00000073          	ecall
 ret
 a52:	8082                	ret

0000000000000a54 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 a54:	1101                	addi	sp,sp,-32
 a56:	ec06                	sd	ra,24(sp)
 a58:	e822                	sd	s0,16(sp)
 a5a:	1000                	addi	s0,sp,32
 a5c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 a60:	4605                	li	a2,1
 a62:	fef40593          	addi	a1,s0,-17
 a66:	00000097          	auipc	ra,0x0
 a6a:	f6e080e7          	jalr	-146(ra) # 9d4 <write>
}
 a6e:	60e2                	ld	ra,24(sp)
 a70:	6442                	ld	s0,16(sp)
 a72:	6105                	addi	sp,sp,32
 a74:	8082                	ret

0000000000000a76 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 a76:	7139                	addi	sp,sp,-64
 a78:	fc06                	sd	ra,56(sp)
 a7a:	f822                	sd	s0,48(sp)
 a7c:	f426                	sd	s1,40(sp)
 a7e:	f04a                	sd	s2,32(sp)
 a80:	ec4e                	sd	s3,24(sp)
 a82:	0080                	addi	s0,sp,64
 a84:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 a86:	c299                	beqz	a3,a8c <printint+0x16>
 a88:	0805c963          	bltz	a1,b1a <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 a8c:	2581                	sext.w	a1,a1
  neg = 0;
 a8e:	4881                	li	a7,0
 a90:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 a94:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 a96:	2601                	sext.w	a2,a2
 a98:	00000517          	auipc	a0,0x0
 a9c:	5c850513          	addi	a0,a0,1480 # 1060 <digits>
 aa0:	883a                	mv	a6,a4
 aa2:	2705                	addiw	a4,a4,1
 aa4:	02c5f7bb          	remuw	a5,a1,a2
 aa8:	1782                	slli	a5,a5,0x20
 aaa:	9381                	srli	a5,a5,0x20
 aac:	97aa                	add	a5,a5,a0
 aae:	0007c783          	lbu	a5,0(a5)
 ab2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 ab6:	0005879b          	sext.w	a5,a1
 aba:	02c5d5bb          	divuw	a1,a1,a2
 abe:	0685                	addi	a3,a3,1
 ac0:	fec7f0e3          	bgeu	a5,a2,aa0 <printint+0x2a>
  if(neg)
 ac4:	00088c63          	beqz	a7,adc <printint+0x66>
    buf[i++] = '-';
 ac8:	fd070793          	addi	a5,a4,-48
 acc:	00878733          	add	a4,a5,s0
 ad0:	02d00793          	li	a5,45
 ad4:	fef70823          	sb	a5,-16(a4)
 ad8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 adc:	02e05863          	blez	a4,b0c <printint+0x96>
 ae0:	fc040793          	addi	a5,s0,-64
 ae4:	00e78933          	add	s2,a5,a4
 ae8:	fff78993          	addi	s3,a5,-1
 aec:	99ba                	add	s3,s3,a4
 aee:	377d                	addiw	a4,a4,-1
 af0:	1702                	slli	a4,a4,0x20
 af2:	9301                	srli	a4,a4,0x20
 af4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 af8:	fff94583          	lbu	a1,-1(s2)
 afc:	8526                	mv	a0,s1
 afe:	00000097          	auipc	ra,0x0
 b02:	f56080e7          	jalr	-170(ra) # a54 <putc>
  while(--i >= 0)
 b06:	197d                	addi	s2,s2,-1
 b08:	ff3918e3          	bne	s2,s3,af8 <printint+0x82>
}
 b0c:	70e2                	ld	ra,56(sp)
 b0e:	7442                	ld	s0,48(sp)
 b10:	74a2                	ld	s1,40(sp)
 b12:	7902                	ld	s2,32(sp)
 b14:	69e2                	ld	s3,24(sp)
 b16:	6121                	addi	sp,sp,64
 b18:	8082                	ret
    x = -xx;
 b1a:	40b005bb          	negw	a1,a1
    neg = 1;
 b1e:	4885                	li	a7,1
    x = -xx;
 b20:	bf85                	j	a90 <printint+0x1a>

0000000000000b22 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 b22:	7119                	addi	sp,sp,-128
 b24:	fc86                	sd	ra,120(sp)
 b26:	f8a2                	sd	s0,112(sp)
 b28:	f4a6                	sd	s1,104(sp)
 b2a:	f0ca                	sd	s2,96(sp)
 b2c:	ecce                	sd	s3,88(sp)
 b2e:	e8d2                	sd	s4,80(sp)
 b30:	e4d6                	sd	s5,72(sp)
 b32:	e0da                	sd	s6,64(sp)
 b34:	fc5e                	sd	s7,56(sp)
 b36:	f862                	sd	s8,48(sp)
 b38:	f466                	sd	s9,40(sp)
 b3a:	f06a                	sd	s10,32(sp)
 b3c:	ec6e                	sd	s11,24(sp)
 b3e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 b40:	0005c903          	lbu	s2,0(a1)
 b44:	18090f63          	beqz	s2,ce2 <vprintf+0x1c0>
 b48:	8aaa                	mv	s5,a0
 b4a:	8b32                	mv	s6,a2
 b4c:	00158493          	addi	s1,a1,1
  state = 0;
 b50:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 b52:	02500a13          	li	s4,37
 b56:	4c55                	li	s8,21
 b58:	00000c97          	auipc	s9,0x0
 b5c:	4b0c8c93          	addi	s9,s9,1200 # 1008 <malloc+0x222>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 b60:	02800d93          	li	s11,40
  putc(fd, 'x');
 b64:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 b66:	00000b97          	auipc	s7,0x0
 b6a:	4fab8b93          	addi	s7,s7,1274 # 1060 <digits>
 b6e:	a839                	j	b8c <vprintf+0x6a>
        putc(fd, c);
 b70:	85ca                	mv	a1,s2
 b72:	8556                	mv	a0,s5
 b74:	00000097          	auipc	ra,0x0
 b78:	ee0080e7          	jalr	-288(ra) # a54 <putc>
 b7c:	a019                	j	b82 <vprintf+0x60>
    } else if(state == '%'){
 b7e:	01498d63          	beq	s3,s4,b98 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 b82:	0485                	addi	s1,s1,1
 b84:	fff4c903          	lbu	s2,-1(s1)
 b88:	14090d63          	beqz	s2,ce2 <vprintf+0x1c0>
    if(state == 0){
 b8c:	fe0999e3          	bnez	s3,b7e <vprintf+0x5c>
      if(c == '%'){
 b90:	ff4910e3          	bne	s2,s4,b70 <vprintf+0x4e>
        state = '%';
 b94:	89d2                	mv	s3,s4
 b96:	b7f5                	j	b82 <vprintf+0x60>
      if(c == 'd'){
 b98:	11490c63          	beq	s2,s4,cb0 <vprintf+0x18e>
 b9c:	f9d9079b          	addiw	a5,s2,-99
 ba0:	0ff7f793          	zext.b	a5,a5
 ba4:	10fc6e63          	bltu	s8,a5,cc0 <vprintf+0x19e>
 ba8:	f9d9079b          	addiw	a5,s2,-99
 bac:	0ff7f713          	zext.b	a4,a5
 bb0:	10ec6863          	bltu	s8,a4,cc0 <vprintf+0x19e>
 bb4:	00271793          	slli	a5,a4,0x2
 bb8:	97e6                	add	a5,a5,s9
 bba:	439c                	lw	a5,0(a5)
 bbc:	97e6                	add	a5,a5,s9
 bbe:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 bc0:	008b0913          	addi	s2,s6,8
 bc4:	4685                	li	a3,1
 bc6:	4629                	li	a2,10
 bc8:	000b2583          	lw	a1,0(s6)
 bcc:	8556                	mv	a0,s5
 bce:	00000097          	auipc	ra,0x0
 bd2:	ea8080e7          	jalr	-344(ra) # a76 <printint>
 bd6:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 bd8:	4981                	li	s3,0
 bda:	b765                	j	b82 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 bdc:	008b0913          	addi	s2,s6,8
 be0:	4681                	li	a3,0
 be2:	4629                	li	a2,10
 be4:	000b2583          	lw	a1,0(s6)
 be8:	8556                	mv	a0,s5
 bea:	00000097          	auipc	ra,0x0
 bee:	e8c080e7          	jalr	-372(ra) # a76 <printint>
 bf2:	8b4a                	mv	s6,s2
      state = 0;
 bf4:	4981                	li	s3,0
 bf6:	b771                	j	b82 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 bf8:	008b0913          	addi	s2,s6,8
 bfc:	4681                	li	a3,0
 bfe:	866a                	mv	a2,s10
 c00:	000b2583          	lw	a1,0(s6)
 c04:	8556                	mv	a0,s5
 c06:	00000097          	auipc	ra,0x0
 c0a:	e70080e7          	jalr	-400(ra) # a76 <printint>
 c0e:	8b4a                	mv	s6,s2
      state = 0;
 c10:	4981                	li	s3,0
 c12:	bf85                	j	b82 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 c14:	008b0793          	addi	a5,s6,8
 c18:	f8f43423          	sd	a5,-120(s0)
 c1c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 c20:	03000593          	li	a1,48
 c24:	8556                	mv	a0,s5
 c26:	00000097          	auipc	ra,0x0
 c2a:	e2e080e7          	jalr	-466(ra) # a54 <putc>
  putc(fd, 'x');
 c2e:	07800593          	li	a1,120
 c32:	8556                	mv	a0,s5
 c34:	00000097          	auipc	ra,0x0
 c38:	e20080e7          	jalr	-480(ra) # a54 <putc>
 c3c:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 c3e:	03c9d793          	srli	a5,s3,0x3c
 c42:	97de                	add	a5,a5,s7
 c44:	0007c583          	lbu	a1,0(a5)
 c48:	8556                	mv	a0,s5
 c4a:	00000097          	auipc	ra,0x0
 c4e:	e0a080e7          	jalr	-502(ra) # a54 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 c52:	0992                	slli	s3,s3,0x4
 c54:	397d                	addiw	s2,s2,-1
 c56:	fe0914e3          	bnez	s2,c3e <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 c5a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 c5e:	4981                	li	s3,0
 c60:	b70d                	j	b82 <vprintf+0x60>
        s = va_arg(ap, char*);
 c62:	008b0913          	addi	s2,s6,8
 c66:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 c6a:	02098163          	beqz	s3,c8c <vprintf+0x16a>
        while(*s != 0){
 c6e:	0009c583          	lbu	a1,0(s3)
 c72:	c5ad                	beqz	a1,cdc <vprintf+0x1ba>
          putc(fd, *s);
 c74:	8556                	mv	a0,s5
 c76:	00000097          	auipc	ra,0x0
 c7a:	dde080e7          	jalr	-546(ra) # a54 <putc>
          s++;
 c7e:	0985                	addi	s3,s3,1
        while(*s != 0){
 c80:	0009c583          	lbu	a1,0(s3)
 c84:	f9e5                	bnez	a1,c74 <vprintf+0x152>
        s = va_arg(ap, char*);
 c86:	8b4a                	mv	s6,s2
      state = 0;
 c88:	4981                	li	s3,0
 c8a:	bde5                	j	b82 <vprintf+0x60>
          s = "(null)";
 c8c:	00000997          	auipc	s3,0x0
 c90:	37498993          	addi	s3,s3,884 # 1000 <malloc+0x21a>
        while(*s != 0){
 c94:	85ee                	mv	a1,s11
 c96:	bff9                	j	c74 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 c98:	008b0913          	addi	s2,s6,8
 c9c:	000b4583          	lbu	a1,0(s6)
 ca0:	8556                	mv	a0,s5
 ca2:	00000097          	auipc	ra,0x0
 ca6:	db2080e7          	jalr	-590(ra) # a54 <putc>
 caa:	8b4a                	mv	s6,s2
      state = 0;
 cac:	4981                	li	s3,0
 cae:	bdd1                	j	b82 <vprintf+0x60>
        putc(fd, c);
 cb0:	85d2                	mv	a1,s4
 cb2:	8556                	mv	a0,s5
 cb4:	00000097          	auipc	ra,0x0
 cb8:	da0080e7          	jalr	-608(ra) # a54 <putc>
      state = 0;
 cbc:	4981                	li	s3,0
 cbe:	b5d1                	j	b82 <vprintf+0x60>
        putc(fd, '%');
 cc0:	85d2                	mv	a1,s4
 cc2:	8556                	mv	a0,s5
 cc4:	00000097          	auipc	ra,0x0
 cc8:	d90080e7          	jalr	-624(ra) # a54 <putc>
        putc(fd, c);
 ccc:	85ca                	mv	a1,s2
 cce:	8556                	mv	a0,s5
 cd0:	00000097          	auipc	ra,0x0
 cd4:	d84080e7          	jalr	-636(ra) # a54 <putc>
      state = 0;
 cd8:	4981                	li	s3,0
 cda:	b565                	j	b82 <vprintf+0x60>
        s = va_arg(ap, char*);
 cdc:	8b4a                	mv	s6,s2
      state = 0;
 cde:	4981                	li	s3,0
 ce0:	b54d                	j	b82 <vprintf+0x60>
    }
  }
}
 ce2:	70e6                	ld	ra,120(sp)
 ce4:	7446                	ld	s0,112(sp)
 ce6:	74a6                	ld	s1,104(sp)
 ce8:	7906                	ld	s2,96(sp)
 cea:	69e6                	ld	s3,88(sp)
 cec:	6a46                	ld	s4,80(sp)
 cee:	6aa6                	ld	s5,72(sp)
 cf0:	6b06                	ld	s6,64(sp)
 cf2:	7be2                	ld	s7,56(sp)
 cf4:	7c42                	ld	s8,48(sp)
 cf6:	7ca2                	ld	s9,40(sp)
 cf8:	7d02                	ld	s10,32(sp)
 cfa:	6de2                	ld	s11,24(sp)
 cfc:	6109                	addi	sp,sp,128
 cfe:	8082                	ret

0000000000000d00 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 d00:	715d                	addi	sp,sp,-80
 d02:	ec06                	sd	ra,24(sp)
 d04:	e822                	sd	s0,16(sp)
 d06:	1000                	addi	s0,sp,32
 d08:	e010                	sd	a2,0(s0)
 d0a:	e414                	sd	a3,8(s0)
 d0c:	e818                	sd	a4,16(s0)
 d0e:	ec1c                	sd	a5,24(s0)
 d10:	03043023          	sd	a6,32(s0)
 d14:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 d18:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 d1c:	8622                	mv	a2,s0
 d1e:	00000097          	auipc	ra,0x0
 d22:	e04080e7          	jalr	-508(ra) # b22 <vprintf>
}
 d26:	60e2                	ld	ra,24(sp)
 d28:	6442                	ld	s0,16(sp)
 d2a:	6161                	addi	sp,sp,80
 d2c:	8082                	ret

0000000000000d2e <printf>:

void
printf(const char *fmt, ...)
{
 d2e:	711d                	addi	sp,sp,-96
 d30:	ec06                	sd	ra,24(sp)
 d32:	e822                	sd	s0,16(sp)
 d34:	1000                	addi	s0,sp,32
 d36:	e40c                	sd	a1,8(s0)
 d38:	e810                	sd	a2,16(s0)
 d3a:	ec14                	sd	a3,24(s0)
 d3c:	f018                	sd	a4,32(s0)
 d3e:	f41c                	sd	a5,40(s0)
 d40:	03043823          	sd	a6,48(s0)
 d44:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 d48:	00840613          	addi	a2,s0,8
 d4c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 d50:	85aa                	mv	a1,a0
 d52:	4505                	li	a0,1
 d54:	00000097          	auipc	ra,0x0
 d58:	dce080e7          	jalr	-562(ra) # b22 <vprintf>
}
 d5c:	60e2                	ld	ra,24(sp)
 d5e:	6442                	ld	s0,16(sp)
 d60:	6125                	addi	sp,sp,96
 d62:	8082                	ret

0000000000000d64 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 d64:	1141                	addi	sp,sp,-16
 d66:	e422                	sd	s0,8(sp)
 d68:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 d6a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d6e:	00001797          	auipc	a5,0x1
 d72:	2927b783          	ld	a5,658(a5) # 2000 <freep>
 d76:	a02d                	j	da0 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 d78:	4618                	lw	a4,8(a2)
 d7a:	9f2d                	addw	a4,a4,a1
 d7c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 d80:	6398                	ld	a4,0(a5)
 d82:	6310                	ld	a2,0(a4)
 d84:	a83d                	j	dc2 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 d86:	ff852703          	lw	a4,-8(a0)
 d8a:	9f31                	addw	a4,a4,a2
 d8c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 d8e:	ff053683          	ld	a3,-16(a0)
 d92:	a091                	j	dd6 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d94:	6398                	ld	a4,0(a5)
 d96:	00e7e463          	bltu	a5,a4,d9e <free+0x3a>
 d9a:	00e6ea63          	bltu	a3,a4,dae <free+0x4a>
{
 d9e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 da0:	fed7fae3          	bgeu	a5,a3,d94 <free+0x30>
 da4:	6398                	ld	a4,0(a5)
 da6:	00e6e463          	bltu	a3,a4,dae <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 daa:	fee7eae3          	bltu	a5,a4,d9e <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 dae:	ff852583          	lw	a1,-8(a0)
 db2:	6390                	ld	a2,0(a5)
 db4:	02059813          	slli	a6,a1,0x20
 db8:	01c85713          	srli	a4,a6,0x1c
 dbc:	9736                	add	a4,a4,a3
 dbe:	fae60de3          	beq	a2,a4,d78 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 dc2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 dc6:	4790                	lw	a2,8(a5)
 dc8:	02061593          	slli	a1,a2,0x20
 dcc:	01c5d713          	srli	a4,a1,0x1c
 dd0:	973e                	add	a4,a4,a5
 dd2:	fae68ae3          	beq	a3,a4,d86 <free+0x22>
    p->s.ptr = bp->s.ptr;
 dd6:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 dd8:	00001717          	auipc	a4,0x1
 ddc:	22f73423          	sd	a5,552(a4) # 2000 <freep>
}
 de0:	6422                	ld	s0,8(sp)
 de2:	0141                	addi	sp,sp,16
 de4:	8082                	ret

0000000000000de6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 de6:	7139                	addi	sp,sp,-64
 de8:	fc06                	sd	ra,56(sp)
 dea:	f822                	sd	s0,48(sp)
 dec:	f426                	sd	s1,40(sp)
 dee:	f04a                	sd	s2,32(sp)
 df0:	ec4e                	sd	s3,24(sp)
 df2:	e852                	sd	s4,16(sp)
 df4:	e456                	sd	s5,8(sp)
 df6:	e05a                	sd	s6,0(sp)
 df8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 dfa:	02051493          	slli	s1,a0,0x20
 dfe:	9081                	srli	s1,s1,0x20
 e00:	04bd                	addi	s1,s1,15
 e02:	8091                	srli	s1,s1,0x4
 e04:	0014899b          	addiw	s3,s1,1
 e08:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 e0a:	00001517          	auipc	a0,0x1
 e0e:	1f653503          	ld	a0,502(a0) # 2000 <freep>
 e12:	c515                	beqz	a0,e3e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e14:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 e16:	4798                	lw	a4,8(a5)
 e18:	02977f63          	bgeu	a4,s1,e56 <malloc+0x70>
 e1c:	8a4e                	mv	s4,s3
 e1e:	0009871b          	sext.w	a4,s3
 e22:	6685                	lui	a3,0x1
 e24:	00d77363          	bgeu	a4,a3,e2a <malloc+0x44>
 e28:	6a05                	lui	s4,0x1
 e2a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 e2e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 e32:	00001917          	auipc	s2,0x1
 e36:	1ce90913          	addi	s2,s2,462 # 2000 <freep>
  if(p == (char*)-1)
 e3a:	5afd                	li	s5,-1
 e3c:	a895                	j	eb0 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 e3e:	00001797          	auipc	a5,0x1
 e42:	1d278793          	addi	a5,a5,466 # 2010 <base>
 e46:	00001717          	auipc	a4,0x1
 e4a:	1af73d23          	sd	a5,442(a4) # 2000 <freep>
 e4e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 e50:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 e54:	b7e1                	j	e1c <malloc+0x36>
      if(p->s.size == nunits)
 e56:	02e48c63          	beq	s1,a4,e8e <malloc+0xa8>
        p->s.size -= nunits;
 e5a:	4137073b          	subw	a4,a4,s3
 e5e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 e60:	02071693          	slli	a3,a4,0x20
 e64:	01c6d713          	srli	a4,a3,0x1c
 e68:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 e6a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 e6e:	00001717          	auipc	a4,0x1
 e72:	18a73923          	sd	a0,402(a4) # 2000 <freep>
      return (void*)(p + 1);
 e76:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 e7a:	70e2                	ld	ra,56(sp)
 e7c:	7442                	ld	s0,48(sp)
 e7e:	74a2                	ld	s1,40(sp)
 e80:	7902                	ld	s2,32(sp)
 e82:	69e2                	ld	s3,24(sp)
 e84:	6a42                	ld	s4,16(sp)
 e86:	6aa2                	ld	s5,8(sp)
 e88:	6b02                	ld	s6,0(sp)
 e8a:	6121                	addi	sp,sp,64
 e8c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 e8e:	6398                	ld	a4,0(a5)
 e90:	e118                	sd	a4,0(a0)
 e92:	bff1                	j	e6e <malloc+0x88>
  hp->s.size = nu;
 e94:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 e98:	0541                	addi	a0,a0,16
 e9a:	00000097          	auipc	ra,0x0
 e9e:	eca080e7          	jalr	-310(ra) # d64 <free>
  return freep;
 ea2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ea6:	d971                	beqz	a0,e7a <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ea8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 eaa:	4798                	lw	a4,8(a5)
 eac:	fa9775e3          	bgeu	a4,s1,e56 <malloc+0x70>
    if(p == freep)
 eb0:	00093703          	ld	a4,0(s2)
 eb4:	853e                	mv	a0,a5
 eb6:	fef719e3          	bne	a4,a5,ea8 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 eba:	8552                	mv	a0,s4
 ebc:	00000097          	auipc	ra,0x0
 ec0:	b80080e7          	jalr	-1152(ra) # a3c <sbrk>
  if(p == (char*)-1)
 ec4:	fd5518e3          	bne	a0,s5,e94 <malloc+0xae>
        return 0;
 ec8:	4501                	li	a0,0
 eca:	bf45                	j	e7a <malloc+0x94>
