
user/_my_shell:     file format elf64-littleriscv


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
      9c:	048a8a93          	addi	s5,s5,72 # 10e0 <malloc+0xea>
      a0:	a081                	j	e0 <redirection+0x6c>
            x=1;
            if (args[i + 1] == 0) {
                printf("Usage: > filename\n");
      a2:	00001517          	auipc	a0,0x1
      a6:	04650513          	addi	a0,a0,70 # 10e8 <malloc+0xf2>
      aa:	00001097          	auipc	ra,0x1
      ae:	e94080e7          	jalr	-364(ra) # f3e <printf>
                exit(0);
      b2:	4501                	li	a0,0
      b4:	00001097          	auipc	ra,0x1
      b8:	b10080e7          	jalr	-1264(ra) # bc4 <exit>
            }
            int fd1=open(args[i+1], O_WRONLY | O_CREATE | O_TRUNC );
            if (fd1<0){
                printf("Cannot open %s for writing\n",args[i+1]);
      bc:	608c                	ld	a1,0(s1)
      be:	00001517          	auipc	a0,0x1
      c2:	04250513          	addi	a0,a0,66 # 1100 <malloc+0x10a>
      c6:	00001097          	auipc	ra,0x1
      ca:	e78080e7          	jalr	-392(ra) # f3e <printf>
                exit(0);
      ce:	4501                	li	a0,0
      d0:	00001097          	auipc	ra,0x1
      d4:	af4080e7          	jalr	-1292(ra) # bc4 <exit>
    for (int i=0; args[i]!=0;i++){
      d8:	04a1                	addi	s1,s1,8
      da:	ff84b503          	ld	a0,-8(s1)
      de:	c539                	beqz	a0,12c <redirection+0xb8>
        if (strcmp(args[i],">")==0){
      e0:	85d6                	mv	a1,s5
      e2:	00001097          	auipc	ra,0x1
      e6:	892080e7          	jalr	-1902(ra) # 974 <strcmp>
      ea:	f57d                	bnez	a0,d8 <redirection+0x64>
            if (args[i + 1] == 0) {
      ec:	6088                	ld	a0,0(s1)
      ee:	d955                	beqz	a0,a2 <redirection+0x2e>
            int fd1=open(args[i+1], O_WRONLY | O_CREATE | O_TRUNC );
      f0:	60100593          	li	a1,1537
      f4:	00001097          	auipc	ra,0x1
      f8:	b10080e7          	jalr	-1264(ra) # c04 <open>
      fc:	89aa                	mv	s3,a0
            if (fd1<0){
      fe:	fa054fe3          	bltz	a0,bc <redirection+0x48>
            }
            close(1);
     102:	4505                	li	a0,1
     104:	00001097          	auipc	ra,0x1
     108:	ae8080e7          	jalr	-1304(ra) # bec <close>
            dup(fd1);
     10c:	854e                	mv	a0,s3
     10e:	00001097          	auipc	ra,0x1
     112:	b2e080e7          	jalr	-1234(ra) # c3c <dup>
            close(fd1);
     116:	854e                	mv	a0,s3
     118:	00001097          	auipc	ra,0x1
     11c:	ad4080e7          	jalr	-1324(ra) # bec <close>
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
     136:	feea8a93          	addi	s5,s5,-18 # 1120 <malloc+0x12a>
            }
            close(0);
            dup(fd);
            close(fd);

            if (x==1){
     13a:	4b05                	li	s6,1
     13c:	a099                	j	182 <redirection+0x10e>
                printf("Usage: > filename\n");
     13e:	00001517          	auipc	a0,0x1
     142:	faa50513          	addi	a0,a0,-86 # 10e8 <malloc+0xf2>
     146:	00001097          	auipc	ra,0x1
     14a:	df8080e7          	jalr	-520(ra) # f3e <printf>
                exit(0);
     14e:	4501                	li	a0,0
     150:	00001097          	auipc	ra,0x1
     154:	a74080e7          	jalr	-1420(ra) # bc4 <exit>
                printf("Cannot open %s for reading\n",args[i+1]);
     158:	00093583          	ld	a1,0(s2)
     15c:	00001517          	auipc	a0,0x1
     160:	fcc50513          	addi	a0,a0,-52 # 1128 <malloc+0x132>
     164:	00001097          	auipc	ra,0x1
     168:	dda080e7          	jalr	-550(ra) # f3e <printf>
                exit(0);
     16c:	4501                	li	a0,0
     16e:	00001097          	auipc	ra,0x1
     172:	a56080e7          	jalr	-1450(ra) # bc4 <exit>
                args[i]=0;     
     176:	fe093c23          	sd	zero,-8(s2)
    for (int i=0; args[i]!=0;i++){    
     17a:	0921                	addi	s2,s2,8
     17c:	ff893503          	ld	a0,-8(s2)
     180:	c921                	beqz	a0,1d0 <redirection+0x15c>
        if(strcmp(args[i],"<")==0){
     182:	85d6                	mv	a1,s5
     184:	00000097          	auipc	ra,0x0
     188:	7f0080e7          	jalr	2032(ra) # 974 <strcmp>
     18c:	f57d                	bnez	a0,17a <redirection+0x106>
            if (args[i + 1] == 0) {
     18e:	00093503          	ld	a0,0(s2)
     192:	d555                	beqz	a0,13e <redirection+0xca>
            int fd=open(args[i+1],O_RDONLY);
     194:	4581                	li	a1,0
     196:	00001097          	auipc	ra,0x1
     19a:	a6e080e7          	jalr	-1426(ra) # c04 <open>
     19e:	84aa                	mv	s1,a0
            if (fd<0){
     1a0:	fa054ce3          	bltz	a0,158 <redirection+0xe4>
            close(0);
     1a4:	4501                	li	a0,0
     1a6:	00001097          	auipc	ra,0x1
     1aa:	a46080e7          	jalr	-1466(ra) # bec <close>
            dup(fd);
     1ae:	8526                	mv	a0,s1
     1b0:	00001097          	auipc	ra,0x1
     1b4:	a8c080e7          	jalr	-1396(ra) # c3c <dup>
            close(fd);
     1b8:	8526                	mv	a0,s1
     1ba:	00001097          	auipc	ra,0x1
     1be:	a32080e7          	jalr	-1486(ra) # bec <close>
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

00000000000001e4 <redirectionPipe>:


void redirectionPipe(char *args[], int point, int isLastSegment) {
     1e4:	715d                	addi	sp,sp,-80
     1e6:	e486                	sd	ra,72(sp)
     1e8:	e0a2                	sd	s0,64(sp)
     1ea:	fc26                	sd	s1,56(sp)
     1ec:	f84a                	sd	s2,48(sp)
     1ee:	f44e                	sd	s3,40(sp)
     1f0:	f052                	sd	s4,32(sp)
     1f2:	ec56                	sd	s5,24(sp)
     1f4:	e85a                	sd	s6,16(sp)
     1f6:	e45e                	sd	s7,8(sp)
     1f8:	0880                	addi	s0,sp,80
     1fa:	84aa                	mv	s1,a0
    for (int i = point; args[i] != 0; i++) {
     1fc:	058e                	slli	a1,a1,0x3
     1fe:	00b50933          	add	s2,a0,a1
     202:	00093503          	ld	a0,0(s2)
     206:	12050d63          	beqz	a0,340 <redirectionPipe+0x15c>
     20a:	8b32                	mv	s6,a2
     20c:	05a1                	addi	a1,a1,8
     20e:	94ae                	add	s1,s1,a1
        if (strcmp(args[i], ">") == 0) {
     210:	00001997          	auipc	s3,0x1
     214:	ed098993          	addi	s3,s3,-304 # 10e0 <malloc+0xea>
            close(1);
            dup(fd1);
            close(fd1);
            args[i] = 0;
            args[i + 1] = 0;
        } else if (strcmp(args[i], "<") == 0) {
     218:	00001a97          	auipc	s5,0x1
     21c:	f08a8a93          	addi	s5,s5,-248 # 1120 <malloc+0x12a>
            close(0);
            dup(fd);
            close(fd);
            args[i] = 0;
            args[i + 1] = 0;
        } else if (isLastSegment && strcmp(args[i], ">>") == 0) {
     220:	00001b97          	auipc	s7,0x1
     224:	f40b8b93          	addi	s7,s7,-192 # 1160 <malloc+0x16a>
     228:	a0f9                	j	2f6 <redirectionPipe+0x112>
                printf("Usage: > filename\n");
     22a:	00001517          	auipc	a0,0x1
     22e:	ebe50513          	addi	a0,a0,-322 # 10e8 <malloc+0xf2>
     232:	00001097          	auipc	ra,0x1
     236:	d0c080e7          	jalr	-756(ra) # f3e <printf>
                exit(0);
     23a:	4501                	li	a0,0
     23c:	00001097          	auipc	ra,0x1
     240:	988080e7          	jalr	-1656(ra) # bc4 <exit>
                printf("Cannot open %s for writing\n", args[i + 1]);
     244:	0009b583          	ld	a1,0(s3)
     248:	00001517          	auipc	a0,0x1
     24c:	eb850513          	addi	a0,a0,-328 # 1100 <malloc+0x10a>
     250:	00001097          	auipc	ra,0x1
     254:	cee080e7          	jalr	-786(ra) # f3e <printf>
                exit(0);
     258:	4501                	li	a0,0
     25a:	00001097          	auipc	ra,0x1
     25e:	96a080e7          	jalr	-1686(ra) # bc4 <exit>
        } else if (strcmp(args[i], "<") == 0) {
     262:	8a4a                	mv	s4,s2
     264:	85d6                	mv	a1,s5
     266:	00093503          	ld	a0,0(s2)
     26a:	00000097          	auipc	ra,0x0
     26e:	70a080e7          	jalr	1802(ra) # 974 <strcmp>
     272:	ed25                	bnez	a0,2ea <redirectionPipe+0x106>
            if (args[i + 1] == 0) {
     274:	8926                	mv	s2,s1
     276:	6088                	ld	a0,0(s1)
     278:	cd0d                	beqz	a0,2b2 <redirectionPipe+0xce>
            int fd = open(args[i + 1], O_RDONLY);
     27a:	4581                	li	a1,0
     27c:	00001097          	auipc	ra,0x1
     280:	988080e7          	jalr	-1656(ra) # c04 <open>
     284:	84aa                	mv	s1,a0
            if (fd < 0) {
     286:	04054363          	bltz	a0,2cc <redirectionPipe+0xe8>
            close(0);
     28a:	4501                	li	a0,0
     28c:	00001097          	auipc	ra,0x1
     290:	960080e7          	jalr	-1696(ra) # bec <close>
            dup(fd);
     294:	8526                	mv	a0,s1
     296:	00001097          	auipc	ra,0x1
     29a:	9a6080e7          	jalr	-1626(ra) # c3c <dup>
            close(fd);
     29e:	8526                	mv	a0,s1
     2a0:	00001097          	auipc	ra,0x1
     2a4:	94c080e7          	jalr	-1716(ra) # bec <close>
            args[i] = 0;
     2a8:	000a3023          	sd	zero,0(s4)
            args[i + 1] = 0;
     2ac:	00093023          	sd	zero,0(s2)
     2b0:	a841                	j	340 <redirectionPipe+0x15c>
                printf("Usage: < filename\n");
     2b2:	00001517          	auipc	a0,0x1
     2b6:	e9650513          	addi	a0,a0,-362 # 1148 <malloc+0x152>
     2ba:	00001097          	auipc	ra,0x1
     2be:	c84080e7          	jalr	-892(ra) # f3e <printf>
                exit(0);
     2c2:	4501                	li	a0,0
     2c4:	00001097          	auipc	ra,0x1
     2c8:	900080e7          	jalr	-1792(ra) # bc4 <exit>
                printf("Cannot open %s for reading\n", args[i + 1]);
     2cc:	00093583          	ld	a1,0(s2)
     2d0:	00001517          	auipc	a0,0x1
     2d4:	e5850513          	addi	a0,a0,-424 # 1128 <malloc+0x132>
     2d8:	00001097          	auipc	ra,0x1
     2dc:	c66080e7          	jalr	-922(ra) # f3e <printf>
                exit(0);
     2e0:	4501                	li	a0,0
     2e2:	00001097          	auipc	ra,0x1
     2e6:	8e2080e7          	jalr	-1822(ra) # bc4 <exit>
        } else if (isLastSegment && strcmp(args[i], ">>") == 0) {
     2ea:	060b1663          	bnez	s6,356 <redirectionPipe+0x172>
    for (int i = point; args[i] != 0; i++) {
     2ee:	6088                	ld	a0,0(s1)
     2f0:	04a1                	addi	s1,s1,8
     2f2:	0921                	addi	s2,s2,8
     2f4:	c531                	beqz	a0,340 <redirectionPipe+0x15c>
        if (strcmp(args[i], ">") == 0) {
     2f6:	85ce                	mv	a1,s3
     2f8:	00000097          	auipc	ra,0x0
     2fc:	67c080e7          	jalr	1660(ra) # 974 <strcmp>
     300:	f12d                	bnez	a0,262 <redirectionPipe+0x7e>
            if (args[i + 1] == 0) {
     302:	89a6                	mv	s3,s1
     304:	6088                	ld	a0,0(s1)
     306:	d115                	beqz	a0,22a <redirectionPipe+0x46>
            int fd1 = open(args[i + 1], O_CREATE | O_WRONLY | O_TRUNC);
     308:	60100593          	li	a1,1537
     30c:	00001097          	auipc	ra,0x1
     310:	8f8080e7          	jalr	-1800(ra) # c04 <open>
     314:	84aa                	mv	s1,a0
            if (fd1 < 0) {
     316:	f20547e3          	bltz	a0,244 <redirectionPipe+0x60>
            close(1);
     31a:	4505                	li	a0,1
     31c:	00001097          	auipc	ra,0x1
     320:	8d0080e7          	jalr	-1840(ra) # bec <close>
            dup(fd1);
     324:	8526                	mv	a0,s1
     326:	00001097          	auipc	ra,0x1
     32a:	916080e7          	jalr	-1770(ra) # c3c <dup>
            close(fd1);
     32e:	8526                	mv	a0,s1
     330:	00001097          	auipc	ra,0x1
     334:	8bc080e7          	jalr	-1860(ra) # bec <close>
            args[i] = 0;
     338:	00093023          	sd	zero,0(s2)
            args[i + 1] = 0;
     33c:	0009b023          	sd	zero,0(s3)
            close(fd1);
            args[i] = 0;
            args[i + 1] = 0;
        }
    }
}
     340:	60a6                	ld	ra,72(sp)
     342:	6406                	ld	s0,64(sp)
     344:	74e2                	ld	s1,56(sp)
     346:	7942                	ld	s2,48(sp)
     348:	79a2                	ld	s3,40(sp)
     34a:	7a02                	ld	s4,32(sp)
     34c:	6ae2                	ld	s5,24(sp)
     34e:	6b42                	ld	s6,16(sp)
     350:	6ba2                	ld	s7,8(sp)
     352:	6161                	addi	sp,sp,80
     354:	8082                	ret
        } else if (isLastSegment && strcmp(args[i], ">>") == 0) {
     356:	85de                	mv	a1,s7
     358:	00093503          	ld	a0,0(s2)
     35c:	00000097          	auipc	ra,0x0
     360:	618080e7          	jalr	1560(ra) # 974 <strcmp>
     364:	f549                	bnez	a0,2ee <redirectionPipe+0x10a>
            if (args[i + 1] == 0) {
     366:	8926                	mv	s2,s1
     368:	6088                	ld	a0,0(s1)
     36a:	cd15                	beqz	a0,3a6 <redirectionPipe+0x1c2>
            int fd1 = open(args[i + 1], O_CREATE | O_WRONLY);
     36c:	20100593          	li	a1,513
     370:	00001097          	auipc	ra,0x1
     374:	894080e7          	jalr	-1900(ra) # c04 <open>
     378:	84aa                	mv	s1,a0
            if (fd1 < 0) {
     37a:	04054363          	bltz	a0,3c0 <redirectionPipe+0x1dc>
            close(1);
     37e:	4505                	li	a0,1
     380:	00001097          	auipc	ra,0x1
     384:	86c080e7          	jalr	-1940(ra) # bec <close>
            dup(fd1);
     388:	8526                	mv	a0,s1
     38a:	00001097          	auipc	ra,0x1
     38e:	8b2080e7          	jalr	-1870(ra) # c3c <dup>
            close(fd1);
     392:	8526                	mv	a0,s1
     394:	00001097          	auipc	ra,0x1
     398:	858080e7          	jalr	-1960(ra) # bec <close>
            args[i] = 0;
     39c:	000a3023          	sd	zero,0(s4)
            args[i + 1] = 0;
     3a0:	00093023          	sd	zero,0(s2)
     3a4:	bf71                	j	340 <redirectionPipe+0x15c>
                printf("Usage: >> filename\n");
     3a6:	00001517          	auipc	a0,0x1
     3aa:	dc250513          	addi	a0,a0,-574 # 1168 <malloc+0x172>
     3ae:	00001097          	auipc	ra,0x1
     3b2:	b90080e7          	jalr	-1136(ra) # f3e <printf>
                exit(0);
     3b6:	4501                	li	a0,0
     3b8:	00001097          	auipc	ra,0x1
     3bc:	80c080e7          	jalr	-2036(ra) # bc4 <exit>
                printf("Cannot open %s for writing\n", args[i + 1]);
     3c0:	00093583          	ld	a1,0(s2)
     3c4:	00001517          	auipc	a0,0x1
     3c8:	d3c50513          	addi	a0,a0,-708 # 1100 <malloc+0x10a>
     3cc:	00001097          	auipc	ra,0x1
     3d0:	b72080e7          	jalr	-1166(ra) # f3e <printf>
                exit(0);
     3d4:	4501                	li	a0,0
     3d6:	00000097          	auipc	ra,0x0
     3da:	7ee080e7          	jalr	2030(ra) # bc4 <exit>

00000000000003de <executeCommand>:





void executeCommand(char *args[]){
     3de:	1101                	addi	sp,sp,-32
     3e0:	ec06                	sd	ra,24(sp)
     3e2:	e822                	sd	s0,16(sp)
     3e4:	e426                	sd	s1,8(sp)
     3e6:	1000                	addi	s0,sp,32
     3e8:	84aa                	mv	s1,a0
    int pid = fork();
     3ea:	00000097          	auipc	ra,0x0
     3ee:	7d2080e7          	jalr	2002(ra) # bbc <fork>
    if (pid < 0) {
     3f2:	00054d63          	bltz	a0,40c <executeCommand+0x2e>
        printf("Fork failed\n");
    } else if (pid == 0) {
     3f6:	c505                	beqz	a0,41e <executeCommand+0x40>
        // If exec fails, print an error message
        printf("Command not found: %s\n", args[0]);
        exit(0);
    } else {
        // This is the parent process
        wait(0);
     3f8:	4501                	li	a0,0
     3fa:	00000097          	auipc	ra,0x0
     3fe:	7d2080e7          	jalr	2002(ra) # bcc <wait>


    }
}
     402:	60e2                	ld	ra,24(sp)
     404:	6442                	ld	s0,16(sp)
     406:	64a2                	ld	s1,8(sp)
     408:	6105                	addi	sp,sp,32
     40a:	8082                	ret
        printf("Fork failed\n");
     40c:	00001517          	auipc	a0,0x1
     410:	d7450513          	addi	a0,a0,-652 # 1180 <malloc+0x18a>
     414:	00001097          	auipc	ra,0x1
     418:	b2a080e7          	jalr	-1238(ra) # f3e <printf>
     41c:	b7dd                	j	402 <executeCommand+0x24>
        redirection(args);
     41e:	8526                	mv	a0,s1
     420:	00000097          	auipc	ra,0x0
     424:	c54080e7          	jalr	-940(ra) # 74 <redirection>
        exec(args[0], args);
     428:	85a6                	mv	a1,s1
     42a:	6088                	ld	a0,0(s1)
     42c:	00000097          	auipc	ra,0x0
     430:	7d0080e7          	jalr	2000(ra) # bfc <exec>
        printf("Command not found: %s\n", args[0]);
     434:	608c                	ld	a1,0(s1)
     436:	00001517          	auipc	a0,0x1
     43a:	d5a50513          	addi	a0,a0,-678 # 1190 <malloc+0x19a>
     43e:	00001097          	auipc	ra,0x1
     442:	b00080e7          	jalr	-1280(ra) # f3e <printf>
        exit(0);
     446:	4501                	li	a0,0
     448:	00000097          	auipc	ra,0x0
     44c:	77c080e7          	jalr	1916(ra) # bc4 <exit>

0000000000000450 <createPipeDesc>:
    int index[2];
} PipeDescriptor;



void createPipeDesc(PipeDescriptor *pipeDesc){
     450:	1141                	addi	sp,sp,-16
     452:	e406                	sd	ra,8(sp)
     454:	e022                	sd	s0,0(sp)
     456:	0800                	addi	s0,sp,16
    if (pipe(pipeDesc->pipe_fds)==-1){
     458:	00000097          	auipc	ra,0x0
     45c:	77c080e7          	jalr	1916(ra) # bd4 <pipe>
     460:	57fd                	li	a5,-1
     462:	00f50663          	beq	a0,a5,46e <createPipeDesc+0x1e>
        printf("Pipe creation failed");
        exit(1);
    }
}
     466:	60a2                	ld	ra,8(sp)
     468:	6402                	ld	s0,0(sp)
     46a:	0141                	addi	sp,sp,16
     46c:	8082                	ret
        printf("Pipe creation failed");
     46e:	00001517          	auipc	a0,0x1
     472:	d3a50513          	addi	a0,a0,-710 # 11a8 <malloc+0x1b2>
     476:	00001097          	auipc	ra,0x1
     47a:	ac8080e7          	jalr	-1336(ra) # f3e <printf>
        exit(1);
     47e:	4505                	li	a0,1
     480:	00000097          	auipc	ra,0x0
     484:	744080e7          	jalr	1860(ra) # bc4 <exit>

0000000000000488 <segmentHandler>:
//     close(pipeDesc->pipe_fds[1]);
// }



void segmentHandler(char *args[], int num_args, int pipePosition[], int pipesFound) {
     488:	715d                	addi	sp,sp,-80
     48a:	e486                	sd	ra,72(sp)
     48c:	e0a2                	sd	s0,64(sp)
     48e:	fc26                	sd	s1,56(sp)
     490:	f84a                	sd	s2,48(sp)
     492:	f44e                	sd	s3,40(sp)
     494:	0880                	addi	s0,sp,80
     496:	89aa                	mv	s3,a0
     498:	84b2                	mv	s1,a2
     49a:	8936                	mv	s2,a3
    PipeDescriptor pipeDesc;
    createPipeDesc(&pipeDesc);
     49c:	fb040513          	addi	a0,s0,-80
     4a0:	00000097          	auipc	ra,0x0
     4a4:	fb0080e7          	jalr	-80(ra) # 450 <createPipeDesc>
    int pid1, pid2;
    pipeDesc.index[0] = pipePosition[0]+1;
     4a8:	409c                	lw	a5,0(s1)
     4aa:	2785                	addiw	a5,a5,1
     4ac:	fcf42223          	sw	a5,-60(s0)



    pid1 = fork();
     4b0:	00000097          	auipc	ra,0x0
     4b4:	70c080e7          	jalr	1804(ra) # bbc <fork>
    if (pid1 == 0) {
     4b8:	c911                	beqz	a0,4cc <segmentHandler+0x44>
        // Execute the first command segment
        exec(args[0], args);
        // If exec fails, print an error message
        printf("Execution failed");
        exit(0);
    } else if (pid1 > 0) {
     4ba:	06a04463          	bgtz	a0,522 <segmentHandler+0x9a>
            // If no pipes, wait for the first child to finish
            wait(0);
        }
    }
    // Return to the main while loop after handling pipes
}
     4be:	60a6                	ld	ra,72(sp)
     4c0:	6406                	ld	s0,64(sp)
     4c2:	74e2                	ld	s1,56(sp)
     4c4:	7942                	ld	s2,48(sp)
     4c6:	79a2                	ld	s3,40(sp)
     4c8:	6161                	addi	sp,sp,80
     4ca:	8082                	ret
        close(pipeDesc.pipe_fds[0]);
     4cc:	fb042503          	lw	a0,-80(s0)
     4d0:	00000097          	auipc	ra,0x0
     4d4:	71c080e7          	jalr	1820(ra) # bec <close>
        close(1);
     4d8:	4505                	li	a0,1
     4da:	00000097          	auipc	ra,0x0
     4de:	712080e7          	jalr	1810(ra) # bec <close>
        dup(pipeDesc.pipe_fds[1]);
     4e2:	fb442503          	lw	a0,-76(s0)
     4e6:	00000097          	auipc	ra,0x0
     4ea:	756080e7          	jalr	1878(ra) # c3c <dup>
        close(pipeDesc.pipe_fds[1]);
     4ee:	fb442503          	lw	a0,-76(s0)
     4f2:	00000097          	auipc	ra,0x0
     4f6:	6fa080e7          	jalr	1786(ra) # bec <close>
        exec(args[0], args);
     4fa:	85ce                	mv	a1,s3
     4fc:	0009b503          	ld	a0,0(s3)
     500:	00000097          	auipc	ra,0x0
     504:	6fc080e7          	jalr	1788(ra) # bfc <exec>
        printf("Execution failed");
     508:	00001517          	auipc	a0,0x1
     50c:	cb850513          	addi	a0,a0,-840 # 11c0 <malloc+0x1ca>
     510:	00001097          	auipc	ra,0x1
     514:	a2e080e7          	jalr	-1490(ra) # f3e <printf>
        exit(0);
     518:	4501                	li	a0,0
     51a:	00000097          	auipc	ra,0x0
     51e:	6aa080e7          	jalr	1706(ra) # bc4 <exit>
        close(pipeDesc.pipe_fds[1]); // Close write end in the parent
     522:	fb442503          	lw	a0,-76(s0)
     526:	00000097          	auipc	ra,0x0
     52a:	6c6080e7          	jalr	1734(ra) # bec <close>
        if (pipesFound > 0) {
     52e:	09205263          	blez	s2,5b2 <segmentHandler+0x12a>
            pid2 = fork();
     532:	00000097          	auipc	ra,0x0
     536:	68a080e7          	jalr	1674(ra) # bbc <fork>
            if (pid2 == 0) {
     53a:	cd11                	beqz	a0,556 <segmentHandler+0xce>
            } else if (pid2 > 0) {
     53c:	f8a051e3          	blez	a0,4be <segmentHandler+0x36>
                wait(0);
     540:	4501                	li	a0,0
     542:	00000097          	auipc	ra,0x0
     546:	68a080e7          	jalr	1674(ra) # bcc <wait>
                wait(0);
     54a:	4501                	li	a0,0
     54c:	00000097          	auipc	ra,0x0
     550:	680080e7          	jalr	1664(ra) # bcc <wait>
     554:	b7ad                	j	4be <segmentHandler+0x36>
                close(pipeDesc.pipe_fds[1]);
     556:	fb442503          	lw	a0,-76(s0)
     55a:	00000097          	auipc	ra,0x0
     55e:	692080e7          	jalr	1682(ra) # bec <close>
                close(0);
     562:	4501                	li	a0,0
     564:	00000097          	auipc	ra,0x0
     568:	688080e7          	jalr	1672(ra) # bec <close>
                dup(pipeDesc.pipe_fds[0]);
     56c:	fb042503          	lw	a0,-80(s0)
     570:	00000097          	auipc	ra,0x0
     574:	6cc080e7          	jalr	1740(ra) # c3c <dup>
                close(pipeDesc.pipe_fds[0]);
     578:	fb042503          	lw	a0,-80(s0)
     57c:	00000097          	auipc	ra,0x0
     580:	670080e7          	jalr	1648(ra) # bec <close>
                exec(args[pipeDesc.index[0]], args + pipeDesc.index[0]);
     584:	fc442783          	lw	a5,-60(s0)
     588:	078e                	slli	a5,a5,0x3
     58a:	00f985b3          	add	a1,s3,a5
     58e:	6188                	ld	a0,0(a1)
     590:	00000097          	auipc	ra,0x0
     594:	66c080e7          	jalr	1644(ra) # bfc <exec>
                printf("Execution failure");
     598:	00001517          	auipc	a0,0x1
     59c:	c4050513          	addi	a0,a0,-960 # 11d8 <malloc+0x1e2>
     5a0:	00001097          	auipc	ra,0x1
     5a4:	99e080e7          	jalr	-1634(ra) # f3e <printf>
                exit(1);
     5a8:	4505                	li	a0,1
     5aa:	00000097          	auipc	ra,0x0
     5ae:	61a080e7          	jalr	1562(ra) # bc4 <exit>
            wait(0);
     5b2:	4501                	li	a0,0
     5b4:	00000097          	auipc	ra,0x0
     5b8:	618080e7          	jalr	1560(ra) # bcc <wait>
}
     5bc:	b709                	j	4be <segmentHandler+0x36>

00000000000005be <multiElementPipelineHandler>:

void multiElementPipelineHandler(char *args[], int num_args, int pipePosition[], int pipesFound) {
     5be:	715d                	addi	sp,sp,-80
     5c0:	e486                	sd	ra,72(sp)
     5c2:	e0a2                	sd	s0,64(sp)
     5c4:	fc26                	sd	s1,56(sp)
     5c6:	f84a                	sd	s2,48(sp)
     5c8:	f44e                	sd	s3,40(sp)
     5ca:	0880                	addi	s0,sp,80
     5cc:	89aa                	mv	s3,a0
     5ce:	84b2                	mv	s1,a2
     5d0:	8936                	mv	s2,a3
    PipeDescriptor pipeDesc;
    createPipeDesc(&pipeDesc);
     5d2:	fb040513          	addi	a0,s0,-80
     5d6:	00000097          	auipc	ra,0x0
     5da:	e7a080e7          	jalr	-390(ra) # 450 <createPipeDesc>
    pipeDesc.index[0] = pipePosition[0]+1;
     5de:	409c                	lw	a5,0(s1)
     5e0:	2785                	addiw	a5,a5,1
     5e2:	fcf42223          	sw	a5,-60(s0)
    pipeDesc.index[1] = pipePosition[1]+1;
     5e6:	40dc                	lw	a5,4(s1)
     5e8:	2785                	addiw	a5,a5,1
     5ea:	fcf42423          	sw	a5,-56(s0)

    int pid1, pid2, pid3;
    pid1 = fork();
     5ee:	00000097          	auipc	ra,0x0
     5f2:	5ce080e7          	jalr	1486(ra) # bbc <fork>
    if (pid1 == 0) {
     5f6:	c911                	beqz	a0,60a <multiElementPipelineHandler+0x4c>
        redirectionPipe(args,0,0);
        exec(args[0], args);
        // If exec fails, print an error message
        printf("Execution failed");
        exit(0);
    } else if (pid1 > 0) {
     5f8:	06a04b63          	bgtz	a0,66e <multiElementPipelineHandler+0xb0>
                wait(0);
            }
        }
    }
    // Return to the main while loop after handling pipes
}
     5fc:	60a6                	ld	ra,72(sp)
     5fe:	6406                	ld	s0,64(sp)
     600:	74e2                	ld	s1,56(sp)
     602:	7942                	ld	s2,48(sp)
     604:	79a2                	ld	s3,40(sp)
     606:	6161                	addi	sp,sp,80
     608:	8082                	ret
        close(pipeDesc.pipe_fds[0]);
     60a:	fb042503          	lw	a0,-80(s0)
     60e:	00000097          	auipc	ra,0x0
     612:	5de080e7          	jalr	1502(ra) # bec <close>
        close(1);
     616:	4505                	li	a0,1
     618:	00000097          	auipc	ra,0x0
     61c:	5d4080e7          	jalr	1492(ra) # bec <close>
        dup(pipeDesc.pipe_fds[1]);
     620:	fb442503          	lw	a0,-76(s0)
     624:	00000097          	auipc	ra,0x0
     628:	618080e7          	jalr	1560(ra) # c3c <dup>
        close(pipeDesc.pipe_fds[1]);
     62c:	fb442503          	lw	a0,-76(s0)
     630:	00000097          	auipc	ra,0x0
     634:	5bc080e7          	jalr	1468(ra) # bec <close>
        redirectionPipe(args,0,0);
     638:	4601                	li	a2,0
     63a:	4581                	li	a1,0
     63c:	854e                	mv	a0,s3
     63e:	00000097          	auipc	ra,0x0
     642:	ba6080e7          	jalr	-1114(ra) # 1e4 <redirectionPipe>
        exec(args[0], args);
     646:	85ce                	mv	a1,s3
     648:	0009b503          	ld	a0,0(s3)
     64c:	00000097          	auipc	ra,0x0
     650:	5b0080e7          	jalr	1456(ra) # bfc <exec>
        printf("Execution failed");
     654:	00001517          	auipc	a0,0x1
     658:	b6c50513          	addi	a0,a0,-1172 # 11c0 <malloc+0x1ca>
     65c:	00001097          	auipc	ra,0x1
     660:	8e2080e7          	jalr	-1822(ra) # f3e <printf>
        exit(0);
     664:	4501                	li	a0,0
     666:	00000097          	auipc	ra,0x0
     66a:	55e080e7          	jalr	1374(ra) # bc4 <exit>
        close(pipeDesc.pipe_fds[1]); // Close write end in the parent
     66e:	fb442503          	lw	a0,-76(s0)
     672:	00000097          	auipc	ra,0x0
     676:	57a080e7          	jalr	1402(ra) # bec <close>
        if (pipesFound > 0) {
     67a:	f92051e3          	blez	s2,5fc <multiElementPipelineHandler+0x3e>
            pid2 = fork();
     67e:	00000097          	auipc	ra,0x0
     682:	53e080e7          	jalr	1342(ra) # bbc <fork>
            if (pid2 == 0) {
     686:	c921                	beqz	a0,6d6 <multiElementPipelineHandler+0x118>
            } else if (pid2 > 0) {
     688:	12a05563          	blez	a0,7b2 <multiElementPipelineHandler+0x1f4>
                close(pipeDesc.pipe_fds[0]);
     68c:	fb042503          	lw	a0,-80(s0)
     690:	00000097          	auipc	ra,0x0
     694:	55c080e7          	jalr	1372(ra) # bec <close>
                wait(0);
     698:	4501                	li	a0,0
     69a:	00000097          	auipc	ra,0x0
     69e:	532080e7          	jalr	1330(ra) # bcc <wait>
                if (pipesFound > 1) {
     6a2:	4785                	li	a5,1
     6a4:	f527dce3          	bge	a5,s2,5fc <multiElementPipelineHandler+0x3e>
                    pid3 = fork();
     6a8:	00000097          	auipc	ra,0x0
     6ac:	514080e7          	jalr	1300(ra) # bbc <fork>
                    if (pid3 == 0) {
     6b0:	c959                	beqz	a0,746 <multiElementPipelineHandler+0x188>
                    } else if (pid3 > 0) {
     6b2:	f4a055e3          	blez	a0,5fc <multiElementPipelineHandler+0x3e>
                        wait(0);
     6b6:	4501                	li	a0,0
     6b8:	00000097          	auipc	ra,0x0
     6bc:	514080e7          	jalr	1300(ra) # bcc <wait>
                        wait(0);
     6c0:	4501                	li	a0,0
     6c2:	00000097          	auipc	ra,0x0
     6c6:	50a080e7          	jalr	1290(ra) # bcc <wait>
                        wait(0);
     6ca:	4501                	li	a0,0
     6cc:	00000097          	auipc	ra,0x0
     6d0:	500080e7          	jalr	1280(ra) # bcc <wait>
     6d4:	b725                	j	5fc <multiElementPipelineHandler+0x3e>
                close(pipeDesc.pipe_fds[1]);
     6d6:	fb442503          	lw	a0,-76(s0)
     6da:	00000097          	auipc	ra,0x0
     6de:	512080e7          	jalr	1298(ra) # bec <close>
                close(0);
     6e2:	4501                	li	a0,0
     6e4:	00000097          	auipc	ra,0x0
     6e8:	508080e7          	jalr	1288(ra) # bec <close>
                dup(pipeDesc.pipe_fds[0]);
     6ec:	fb042503          	lw	a0,-80(s0)
     6f0:	00000097          	auipc	ra,0x0
     6f4:	54c080e7          	jalr	1356(ra) # c3c <dup>
                close(pipeDesc.pipe_fds[0]);
     6f8:	fb042503          	lw	a0,-80(s0)
     6fc:	00000097          	auipc	ra,0x0
     700:	4f0080e7          	jalr	1264(ra) # bec <close>
                redirectionPipe(args, pipeDesc.index[0],pipesFound==1);
     704:	fff90613          	addi	a2,s2,-1
     708:	00163613          	seqz	a2,a2
     70c:	fc442583          	lw	a1,-60(s0)
     710:	854e                	mv	a0,s3
     712:	00000097          	auipc	ra,0x0
     716:	ad2080e7          	jalr	-1326(ra) # 1e4 <redirectionPipe>
                exec(args[pipeDesc.index[0]], args + pipeDesc.index[0] );
     71a:	fc442583          	lw	a1,-60(s0)
     71e:	058e                	slli	a1,a1,0x3
     720:	95ce                	add	a1,a1,s3
     722:	6188                	ld	a0,0(a1)
     724:	00000097          	auipc	ra,0x0
     728:	4d8080e7          	jalr	1240(ra) # bfc <exec>
                printf("Execution failure");
     72c:	00001517          	auipc	a0,0x1
     730:	aac50513          	addi	a0,a0,-1364 # 11d8 <malloc+0x1e2>
     734:	00001097          	auipc	ra,0x1
     738:	80a080e7          	jalr	-2038(ra) # f3e <printf>
                exit(1);
     73c:	4505                	li	a0,1
     73e:	00000097          	auipc	ra,0x0
     742:	486080e7          	jalr	1158(ra) # bc4 <exit>
                        close(pipeDesc.pipe_fds[2]);
     746:	fb842503          	lw	a0,-72(s0)
     74a:	00000097          	auipc	ra,0x0
     74e:	4a2080e7          	jalr	1186(ra) # bec <close>
                        close(0);
     752:	4501                	li	a0,0
     754:	00000097          	auipc	ra,0x0
     758:	498080e7          	jalr	1176(ra) # bec <close>
                        dup(pipeDesc.pipe_fds[1]);
     75c:	fb442503          	lw	a0,-76(s0)
     760:	00000097          	auipc	ra,0x0
     764:	4dc080e7          	jalr	1244(ra) # c3c <dup>
                        close(pipeDesc.pipe_fds[1]);
     768:	fb442503          	lw	a0,-76(s0)
     76c:	00000097          	auipc	ra,0x0
     770:	480080e7          	jalr	1152(ra) # bec <close>
                        redirectionPipe(args, pipeDesc.index[1],1);
     774:	4605                	li	a2,1
     776:	fc842583          	lw	a1,-56(s0)
     77a:	854e                	mv	a0,s3
     77c:	00000097          	auipc	ra,0x0
     780:	a68080e7          	jalr	-1432(ra) # 1e4 <redirectionPipe>
                        exec(args[pipeDesc.index[1] ], args + pipeDesc.index[1]);
     784:	fc842783          	lw	a5,-56(s0)
     788:	078e                	slli	a5,a5,0x3
     78a:	00f985b3          	add	a1,s3,a5
     78e:	6188                	ld	a0,0(a1)
     790:	00000097          	auipc	ra,0x0
     794:	46c080e7          	jalr	1132(ra) # bfc <exec>
                        printf("Execution failure");
     798:	00001517          	auipc	a0,0x1
     79c:	a4050513          	addi	a0,a0,-1472 # 11d8 <malloc+0x1e2>
     7a0:	00000097          	auipc	ra,0x0
     7a4:	79e080e7          	jalr	1950(ra) # f3e <printf>
                        exit(1);
     7a8:	4505                	li	a0,1
     7aa:	00000097          	auipc	ra,0x0
     7ae:	41a080e7          	jalr	1050(ra) # bc4 <exit>
                wait(0);
     7b2:	4501                	li	a0,0
     7b4:	00000097          	auipc	ra,0x0
     7b8:	418080e7          	jalr	1048(ra) # bcc <wait>
}
     7bc:	b581                	j	5fc <multiElementPipelineHandler+0x3e>

00000000000007be <containsPipe>:
    

int containsPipe(char *args[], int num_args) {
     7be:	715d                	addi	sp,sp,-80
     7c0:	e486                	sd	ra,72(sp)
     7c2:	e0a2                	sd	s0,64(sp)
     7c4:	fc26                	sd	s1,56(sp)
     7c6:	f84a                	sd	s2,48(sp)
     7c8:	f44e                	sd	s3,40(sp)
     7ca:	f052                	sd	s4,32(sp)
     7cc:	ec56                	sd	s5,24(sp)
     7ce:	e85a                	sd	s6,16(sp)
     7d0:	0880                	addi	s0,sp,80
    int pipePosition[3];
    int pipesFound = 0;

    for (int i = 0; i < num_args; i++) {
     7d2:	08b05763          	blez	a1,860 <containsPipe+0xa2>
     7d6:	8b2a                	mv	s6,a0
     7d8:	8a2e                	mv	s4,a1
     7da:	892a                	mv	s2,a0
     7dc:	4481                	li	s1,0
    int pipesFound = 0;
     7de:	4981                	li	s3,0
        if (strcmp(args[i], "|") == 0) {
     7e0:	00001a97          	auipc	s5,0x1
     7e4:	a10a8a93          	addi	s5,s5,-1520 # 11f0 <malloc+0x1fa>
     7e8:	a029                	j	7f2 <containsPipe+0x34>
    for (int i = 0; i < num_args; i++) {
     7ea:	2485                	addiw	s1,s1,1
     7ec:	0921                	addi	s2,s2,8
     7ee:	029a0563          	beq	s4,s1,818 <containsPipe+0x5a>
        if (strcmp(args[i], "|") == 0) {
     7f2:	85d6                	mv	a1,s5
     7f4:	00093503          	ld	a0,0(s2)
     7f8:	00000097          	auipc	ra,0x0
     7fc:	17c080e7          	jalr	380(ra) # 974 <strcmp>
     800:	f56d                	bnez	a0,7ea <containsPipe+0x2c>
            args[i] = 0;
     802:	00093023          	sd	zero,0(s2)
            pipePosition[pipesFound++] = i;
     806:	00299793          	slli	a5,s3,0x2
     80a:	fc078793          	addi	a5,a5,-64
     80e:	97a2                	add	a5,a5,s0
     810:	fe97a823          	sw	s1,-16(a5)
     814:	2985                	addiw	s3,s3,1
     816:	bfd1                	j	7ea <containsPipe+0x2c>
        }
    }

    if (pipesFound > 0) {
     818:	05305663          	blez	s3,864 <containsPipe+0xa6>
        if (pipesFound == 1) {
     81c:	4785                	li	a5,1
     81e:	02f98763          	beq	s3,a5,84c <containsPipe+0x8e>
            // Single-element pipeline
            segmentHandler(args, num_args, pipePosition, pipesFound);
        } else {
            // Multi-element pipeline
            multiElementPipelineHandler(args, num_args, pipePosition, pipesFound);
     822:	86ce                	mv	a3,s3
     824:	fb040613          	addi	a2,s0,-80
     828:	85a6                	mv	a1,s1
     82a:	855a                	mv	a0,s6
     82c:	00000097          	auipc	ra,0x0
     830:	d92080e7          	jalr	-622(ra) # 5be <multiElementPipelineHandler>
        }
        return 1;
     834:	4985                	li	s3,1
    } else {
        // No pipes found
        return 0;
    }
}
     836:	854e                	mv	a0,s3
     838:	60a6                	ld	ra,72(sp)
     83a:	6406                	ld	s0,64(sp)
     83c:	74e2                	ld	s1,56(sp)
     83e:	7942                	ld	s2,48(sp)
     840:	79a2                	ld	s3,40(sp)
     842:	7a02                	ld	s4,32(sp)
     844:	6ae2                	ld	s5,24(sp)
     846:	6b42                	ld	s6,16(sp)
     848:	6161                	addi	sp,sp,80
     84a:	8082                	ret
            segmentHandler(args, num_args, pipePosition, pipesFound);
     84c:	4685                	li	a3,1
     84e:	fb040613          	addi	a2,s0,-80
     852:	85a6                	mv	a1,s1
     854:	855a                	mv	a0,s6
     856:	00000097          	auipc	ra,0x0
     85a:	c32080e7          	jalr	-974(ra) # 488 <segmentHandler>
     85e:	bfe1                	j	836 <containsPipe+0x78>
        return 0;
     860:	4981                	li	s3,0
     862:	bfd1                	j	836 <containsPipe+0x78>
     864:	4981                	li	s3,0
     866:	bfc1                	j	836 <containsPipe+0x78>

0000000000000868 <main>:


int main(int argc, char *argv[]) {
     868:	7165                	addi	sp,sp,-400
     86a:	e706                	sd	ra,392(sp)
     86c:	e322                	sd	s0,384(sp)
     86e:	fea6                	sd	s1,376(sp)
     870:	faca                	sd	s2,368(sp)
     872:	f6ce                	sd	s3,360(sp)
     874:	f2d2                	sd	s4,352(sp)
     876:	eed6                	sd	s5,344(sp)
     878:	eada                	sd	s6,336(sp)
     87a:	0b00                	addi	s0,sp,400
    char buf[MAX_CMD_LEN];
    char *args[MAX_ARGS];
    while (1) {
        const char* Prompt=">>> ";
        write(1,Prompt,strlen(Prompt)); 
     87c:	00001917          	auipc	s2,0x1
     880:	97c90913          	addi	s2,s2,-1668 # 11f8 <malloc+0x202>
        // Tokenize the input command
        int num_args = tokenise(buf, args);
        
        if (num_args > 0) {
            // Check for built-in commands
            if (strcmp(args[0], "cd") == 0) {
     884:	00001997          	auipc	s3,0x1
     888:	97c98993          	addi	s3,s3,-1668 # 1200 <malloc+0x20a>
                if(num_args !=2){
     88c:	4a09                	li	s4,2
                    printf("Usage: cd <directory>\n");

                }else{
                    if (chdir(args[1])<0){
                        printf("cd: cannot change directory to %s\n",args[1]);
     88e:	00001b17          	auipc	s6,0x1
     892:	992b0b13          	addi	s6,s6,-1646 # 1220 <malloc+0x22a>
                    printf("Usage: cd <directory>\n");
     896:	00001a97          	auipc	s5,0x1
     89a:	972a8a93          	addi	s5,s5,-1678 # 1208 <malloc+0x212>
     89e:	a80d                	j	8d0 <main+0x68>
                    if (chdir(args[1])<0){
     8a0:	e7843503          	ld	a0,-392(s0)
     8a4:	00000097          	auipc	ra,0x0
     8a8:	390080e7          	jalr	912(ra) # c34 <chdir>
     8ac:	02055263          	bgez	a0,8d0 <main+0x68>
                        printf("cd: cannot change directory to %s\n",args[1]);
     8b0:	e7843583          	ld	a1,-392(s0)
     8b4:	855a                	mv	a0,s6
     8b6:	00000097          	auipc	ra,0x0
     8ba:	688080e7          	jalr	1672(ra) # f3e <printf>
     8be:	a809                	j	8d0 <main+0x68>
                }    
                
            } else {
                // Fork a child process to execute the command

                if (containsPipe(args,num_args)==0){
     8c0:	85a6                	mv	a1,s1
     8c2:	e7040513          	addi	a0,s0,-400
     8c6:	00000097          	auipc	ra,0x0
     8ca:	ef8080e7          	jalr	-264(ra) # 7be <containsPipe>
     8ce:	c12d                	beqz	a0,930 <main+0xc8>
        write(1,Prompt,strlen(Prompt)); 
     8d0:	854a                	mv	a0,s2
     8d2:	00000097          	auipc	ra,0x0
     8d6:	0ce080e7          	jalr	206(ra) # 9a0 <strlen>
     8da:	0005061b          	sext.w	a2,a0
     8de:	85ca                	mv	a1,s2
     8e0:	4505                	li	a0,1
     8e2:	00000097          	auipc	ra,0x0
     8e6:	302080e7          	jalr	770(ra) # be4 <write>
        gets(buf, sizeof(buf));
     8ea:	10000593          	li	a1,256
     8ee:	ec040513          	addi	a0,s0,-320
     8f2:	00000097          	auipc	ra,0x0
     8f6:	11e080e7          	jalr	286(ra) # a10 <gets>
        int num_args = tokenise(buf, args);
     8fa:	e7040593          	addi	a1,s0,-400
     8fe:	ec040513          	addi	a0,s0,-320
     902:	fffff097          	auipc	ra,0xfffff
     906:	6fe080e7          	jalr	1790(ra) # 0 <tokenise>
     90a:	84aa                	mv	s1,a0
        if (num_args > 0) {
     90c:	fca052e3          	blez	a0,8d0 <main+0x68>
            if (strcmp(args[0], "cd") == 0) {
     910:	85ce                	mv	a1,s3
     912:	e7043503          	ld	a0,-400(s0)
     916:	00000097          	auipc	ra,0x0
     91a:	05e080e7          	jalr	94(ra) # 974 <strcmp>
     91e:	f14d                	bnez	a0,8c0 <main+0x58>
                if(num_args !=2){
     920:	f94480e3          	beq	s1,s4,8a0 <main+0x38>
                    printf("Usage: cd <directory>\n");
     924:	8556                	mv	a0,s5
     926:	00000097          	auipc	ra,0x0
     92a:	618080e7          	jalr	1560(ra) # f3e <printf>
     92e:	b74d                	j	8d0 <main+0x68>
                    executeCommand(args);
     930:	e7040513          	addi	a0,s0,-400
     934:	00000097          	auipc	ra,0x0
     938:	aaa080e7          	jalr	-1366(ra) # 3de <executeCommand>
     93c:	bf51                	j	8d0 <main+0x68>

000000000000093e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
     93e:	1141                	addi	sp,sp,-16
     940:	e406                	sd	ra,8(sp)
     942:	e022                	sd	s0,0(sp)
     944:	0800                	addi	s0,sp,16
  extern int main();
  main();
     946:	00000097          	auipc	ra,0x0
     94a:	f22080e7          	jalr	-222(ra) # 868 <main>
  exit(0);
     94e:	4501                	li	a0,0
     950:	00000097          	auipc	ra,0x0
     954:	274080e7          	jalr	628(ra) # bc4 <exit>

0000000000000958 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     958:	1141                	addi	sp,sp,-16
     95a:	e422                	sd	s0,8(sp)
     95c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     95e:	87aa                	mv	a5,a0
     960:	0585                	addi	a1,a1,1
     962:	0785                	addi	a5,a5,1
     964:	fff5c703          	lbu	a4,-1(a1)
     968:	fee78fa3          	sb	a4,-1(a5)
     96c:	fb75                	bnez	a4,960 <strcpy+0x8>
    ;
  return os;
}
     96e:	6422                	ld	s0,8(sp)
     970:	0141                	addi	sp,sp,16
     972:	8082                	ret

0000000000000974 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     974:	1141                	addi	sp,sp,-16
     976:	e422                	sd	s0,8(sp)
     978:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     97a:	00054783          	lbu	a5,0(a0)
     97e:	cb91                	beqz	a5,992 <strcmp+0x1e>
     980:	0005c703          	lbu	a4,0(a1)
     984:	00f71763          	bne	a4,a5,992 <strcmp+0x1e>
    p++, q++;
     988:	0505                	addi	a0,a0,1
     98a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     98c:	00054783          	lbu	a5,0(a0)
     990:	fbe5                	bnez	a5,980 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     992:	0005c503          	lbu	a0,0(a1)
}
     996:	40a7853b          	subw	a0,a5,a0
     99a:	6422                	ld	s0,8(sp)
     99c:	0141                	addi	sp,sp,16
     99e:	8082                	ret

00000000000009a0 <strlen>:

uint
strlen(const char *s)
{
     9a0:	1141                	addi	sp,sp,-16
     9a2:	e422                	sd	s0,8(sp)
     9a4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     9a6:	00054783          	lbu	a5,0(a0)
     9aa:	cf91                	beqz	a5,9c6 <strlen+0x26>
     9ac:	0505                	addi	a0,a0,1
     9ae:	87aa                	mv	a5,a0
     9b0:	4685                	li	a3,1
     9b2:	9e89                	subw	a3,a3,a0
     9b4:	00f6853b          	addw	a0,a3,a5
     9b8:	0785                	addi	a5,a5,1
     9ba:	fff7c703          	lbu	a4,-1(a5)
     9be:	fb7d                	bnez	a4,9b4 <strlen+0x14>
    ;
  return n;
}
     9c0:	6422                	ld	s0,8(sp)
     9c2:	0141                	addi	sp,sp,16
     9c4:	8082                	ret
  for(n = 0; s[n]; n++)
     9c6:	4501                	li	a0,0
     9c8:	bfe5                	j	9c0 <strlen+0x20>

00000000000009ca <memset>:

void*
memset(void *dst, int c, uint n)
{
     9ca:	1141                	addi	sp,sp,-16
     9cc:	e422                	sd	s0,8(sp)
     9ce:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     9d0:	ca19                	beqz	a2,9e6 <memset+0x1c>
     9d2:	87aa                	mv	a5,a0
     9d4:	1602                	slli	a2,a2,0x20
     9d6:	9201                	srli	a2,a2,0x20
     9d8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     9dc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     9e0:	0785                	addi	a5,a5,1
     9e2:	fee79de3          	bne	a5,a4,9dc <memset+0x12>
  }
  return dst;
}
     9e6:	6422                	ld	s0,8(sp)
     9e8:	0141                	addi	sp,sp,16
     9ea:	8082                	ret

00000000000009ec <strchr>:

char*
strchr(const char *s, char c)
{
     9ec:	1141                	addi	sp,sp,-16
     9ee:	e422                	sd	s0,8(sp)
     9f0:	0800                	addi	s0,sp,16
  for(; *s; s++)
     9f2:	00054783          	lbu	a5,0(a0)
     9f6:	cb99                	beqz	a5,a0c <strchr+0x20>
    if(*s == c)
     9f8:	00f58763          	beq	a1,a5,a06 <strchr+0x1a>
  for(; *s; s++)
     9fc:	0505                	addi	a0,a0,1
     9fe:	00054783          	lbu	a5,0(a0)
     a02:	fbfd                	bnez	a5,9f8 <strchr+0xc>
      return (char*)s;
  return 0;
     a04:	4501                	li	a0,0
}
     a06:	6422                	ld	s0,8(sp)
     a08:	0141                	addi	sp,sp,16
     a0a:	8082                	ret
  return 0;
     a0c:	4501                	li	a0,0
     a0e:	bfe5                	j	a06 <strchr+0x1a>

0000000000000a10 <gets>:

char*
gets(char *buf, int max)
{
     a10:	711d                	addi	sp,sp,-96
     a12:	ec86                	sd	ra,88(sp)
     a14:	e8a2                	sd	s0,80(sp)
     a16:	e4a6                	sd	s1,72(sp)
     a18:	e0ca                	sd	s2,64(sp)
     a1a:	fc4e                	sd	s3,56(sp)
     a1c:	f852                	sd	s4,48(sp)
     a1e:	f456                	sd	s5,40(sp)
     a20:	f05a                	sd	s6,32(sp)
     a22:	ec5e                	sd	s7,24(sp)
     a24:	1080                	addi	s0,sp,96
     a26:	8baa                	mv	s7,a0
     a28:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     a2a:	892a                	mv	s2,a0
     a2c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     a2e:	4aa9                	li	s5,10
     a30:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     a32:	89a6                	mv	s3,s1
     a34:	2485                	addiw	s1,s1,1
     a36:	0344d863          	bge	s1,s4,a66 <gets+0x56>
    cc = read(0, &c, 1);
     a3a:	4605                	li	a2,1
     a3c:	faf40593          	addi	a1,s0,-81
     a40:	4501                	li	a0,0
     a42:	00000097          	auipc	ra,0x0
     a46:	19a080e7          	jalr	410(ra) # bdc <read>
    if(cc < 1)
     a4a:	00a05e63          	blez	a0,a66 <gets+0x56>
    buf[i++] = c;
     a4e:	faf44783          	lbu	a5,-81(s0)
     a52:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     a56:	01578763          	beq	a5,s5,a64 <gets+0x54>
     a5a:	0905                	addi	s2,s2,1
     a5c:	fd679be3          	bne	a5,s6,a32 <gets+0x22>
  for(i=0; i+1 < max; ){
     a60:	89a6                	mv	s3,s1
     a62:	a011                	j	a66 <gets+0x56>
     a64:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     a66:	99de                	add	s3,s3,s7
     a68:	00098023          	sb	zero,0(s3)
  return buf;
}
     a6c:	855e                	mv	a0,s7
     a6e:	60e6                	ld	ra,88(sp)
     a70:	6446                	ld	s0,80(sp)
     a72:	64a6                	ld	s1,72(sp)
     a74:	6906                	ld	s2,64(sp)
     a76:	79e2                	ld	s3,56(sp)
     a78:	7a42                	ld	s4,48(sp)
     a7a:	7aa2                	ld	s5,40(sp)
     a7c:	7b02                	ld	s6,32(sp)
     a7e:	6be2                	ld	s7,24(sp)
     a80:	6125                	addi	sp,sp,96
     a82:	8082                	ret

0000000000000a84 <stat>:

int
stat(const char *n, struct stat *st)
{
     a84:	1101                	addi	sp,sp,-32
     a86:	ec06                	sd	ra,24(sp)
     a88:	e822                	sd	s0,16(sp)
     a8a:	e426                	sd	s1,8(sp)
     a8c:	e04a                	sd	s2,0(sp)
     a8e:	1000                	addi	s0,sp,32
     a90:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     a92:	4581                	li	a1,0
     a94:	00000097          	auipc	ra,0x0
     a98:	170080e7          	jalr	368(ra) # c04 <open>
  if(fd < 0)
     a9c:	02054563          	bltz	a0,ac6 <stat+0x42>
     aa0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     aa2:	85ca                	mv	a1,s2
     aa4:	00000097          	auipc	ra,0x0
     aa8:	178080e7          	jalr	376(ra) # c1c <fstat>
     aac:	892a                	mv	s2,a0
  close(fd);
     aae:	8526                	mv	a0,s1
     ab0:	00000097          	auipc	ra,0x0
     ab4:	13c080e7          	jalr	316(ra) # bec <close>
  return r;
}
     ab8:	854a                	mv	a0,s2
     aba:	60e2                	ld	ra,24(sp)
     abc:	6442                	ld	s0,16(sp)
     abe:	64a2                	ld	s1,8(sp)
     ac0:	6902                	ld	s2,0(sp)
     ac2:	6105                	addi	sp,sp,32
     ac4:	8082                	ret
    return -1;
     ac6:	597d                	li	s2,-1
     ac8:	bfc5                	j	ab8 <stat+0x34>

0000000000000aca <atoi>:

int
atoi(const char *s)
{
     aca:	1141                	addi	sp,sp,-16
     acc:	e422                	sd	s0,8(sp)
     ace:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     ad0:	00054683          	lbu	a3,0(a0)
     ad4:	fd06879b          	addiw	a5,a3,-48
     ad8:	0ff7f793          	zext.b	a5,a5
     adc:	4625                	li	a2,9
     ade:	02f66863          	bltu	a2,a5,b0e <atoi+0x44>
     ae2:	872a                	mv	a4,a0
  n = 0;
     ae4:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     ae6:	0705                	addi	a4,a4,1
     ae8:	0025179b          	slliw	a5,a0,0x2
     aec:	9fa9                	addw	a5,a5,a0
     aee:	0017979b          	slliw	a5,a5,0x1
     af2:	9fb5                	addw	a5,a5,a3
     af4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     af8:	00074683          	lbu	a3,0(a4)
     afc:	fd06879b          	addiw	a5,a3,-48
     b00:	0ff7f793          	zext.b	a5,a5
     b04:	fef671e3          	bgeu	a2,a5,ae6 <atoi+0x1c>
  return n;
}
     b08:	6422                	ld	s0,8(sp)
     b0a:	0141                	addi	sp,sp,16
     b0c:	8082                	ret
  n = 0;
     b0e:	4501                	li	a0,0
     b10:	bfe5                	j	b08 <atoi+0x3e>

0000000000000b12 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     b12:	1141                	addi	sp,sp,-16
     b14:	e422                	sd	s0,8(sp)
     b16:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     b18:	02b57463          	bgeu	a0,a1,b40 <memmove+0x2e>
    while(n-- > 0)
     b1c:	00c05f63          	blez	a2,b3a <memmove+0x28>
     b20:	1602                	slli	a2,a2,0x20
     b22:	9201                	srli	a2,a2,0x20
     b24:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     b28:	872a                	mv	a4,a0
      *dst++ = *src++;
     b2a:	0585                	addi	a1,a1,1
     b2c:	0705                	addi	a4,a4,1
     b2e:	fff5c683          	lbu	a3,-1(a1)
     b32:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     b36:	fee79ae3          	bne	a5,a4,b2a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     b3a:	6422                	ld	s0,8(sp)
     b3c:	0141                	addi	sp,sp,16
     b3e:	8082                	ret
    dst += n;
     b40:	00c50733          	add	a4,a0,a2
    src += n;
     b44:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     b46:	fec05ae3          	blez	a2,b3a <memmove+0x28>
     b4a:	fff6079b          	addiw	a5,a2,-1
     b4e:	1782                	slli	a5,a5,0x20
     b50:	9381                	srli	a5,a5,0x20
     b52:	fff7c793          	not	a5,a5
     b56:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     b58:	15fd                	addi	a1,a1,-1
     b5a:	177d                	addi	a4,a4,-1
     b5c:	0005c683          	lbu	a3,0(a1)
     b60:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     b64:	fee79ae3          	bne	a5,a4,b58 <memmove+0x46>
     b68:	bfc9                	j	b3a <memmove+0x28>

0000000000000b6a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     b6a:	1141                	addi	sp,sp,-16
     b6c:	e422                	sd	s0,8(sp)
     b6e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     b70:	ca05                	beqz	a2,ba0 <memcmp+0x36>
     b72:	fff6069b          	addiw	a3,a2,-1
     b76:	1682                	slli	a3,a3,0x20
     b78:	9281                	srli	a3,a3,0x20
     b7a:	0685                	addi	a3,a3,1
     b7c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     b7e:	00054783          	lbu	a5,0(a0)
     b82:	0005c703          	lbu	a4,0(a1)
     b86:	00e79863          	bne	a5,a4,b96 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     b8a:	0505                	addi	a0,a0,1
    p2++;
     b8c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     b8e:	fed518e3          	bne	a0,a3,b7e <memcmp+0x14>
  }
  return 0;
     b92:	4501                	li	a0,0
     b94:	a019                	j	b9a <memcmp+0x30>
      return *p1 - *p2;
     b96:	40e7853b          	subw	a0,a5,a4
}
     b9a:	6422                	ld	s0,8(sp)
     b9c:	0141                	addi	sp,sp,16
     b9e:	8082                	ret
  return 0;
     ba0:	4501                	li	a0,0
     ba2:	bfe5                	j	b9a <memcmp+0x30>

0000000000000ba4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     ba4:	1141                	addi	sp,sp,-16
     ba6:	e406                	sd	ra,8(sp)
     ba8:	e022                	sd	s0,0(sp)
     baa:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     bac:	00000097          	auipc	ra,0x0
     bb0:	f66080e7          	jalr	-154(ra) # b12 <memmove>
}
     bb4:	60a2                	ld	ra,8(sp)
     bb6:	6402                	ld	s0,0(sp)
     bb8:	0141                	addi	sp,sp,16
     bba:	8082                	ret

0000000000000bbc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     bbc:	4885                	li	a7,1
 ecall
     bbe:	00000073          	ecall
 ret
     bc2:	8082                	ret

0000000000000bc4 <exit>:
.global exit
exit:
 li a7, SYS_exit
     bc4:	4889                	li	a7,2
 ecall
     bc6:	00000073          	ecall
 ret
     bca:	8082                	ret

0000000000000bcc <wait>:
.global wait
wait:
 li a7, SYS_wait
     bcc:	488d                	li	a7,3
 ecall
     bce:	00000073          	ecall
 ret
     bd2:	8082                	ret

0000000000000bd4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     bd4:	4891                	li	a7,4
 ecall
     bd6:	00000073          	ecall
 ret
     bda:	8082                	ret

0000000000000bdc <read>:
.global read
read:
 li a7, SYS_read
     bdc:	4895                	li	a7,5
 ecall
     bde:	00000073          	ecall
 ret
     be2:	8082                	ret

0000000000000be4 <write>:
.global write
write:
 li a7, SYS_write
     be4:	48c1                	li	a7,16
 ecall
     be6:	00000073          	ecall
 ret
     bea:	8082                	ret

0000000000000bec <close>:
.global close
close:
 li a7, SYS_close
     bec:	48d5                	li	a7,21
 ecall
     bee:	00000073          	ecall
 ret
     bf2:	8082                	ret

0000000000000bf4 <kill>:
.global kill
kill:
 li a7, SYS_kill
     bf4:	4899                	li	a7,6
 ecall
     bf6:	00000073          	ecall
 ret
     bfa:	8082                	ret

0000000000000bfc <exec>:
.global exec
exec:
 li a7, SYS_exec
     bfc:	489d                	li	a7,7
 ecall
     bfe:	00000073          	ecall
 ret
     c02:	8082                	ret

0000000000000c04 <open>:
.global open
open:
 li a7, SYS_open
     c04:	48bd                	li	a7,15
 ecall
     c06:	00000073          	ecall
 ret
     c0a:	8082                	ret

0000000000000c0c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     c0c:	48c5                	li	a7,17
 ecall
     c0e:	00000073          	ecall
 ret
     c12:	8082                	ret

0000000000000c14 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     c14:	48c9                	li	a7,18
 ecall
     c16:	00000073          	ecall
 ret
     c1a:	8082                	ret

0000000000000c1c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     c1c:	48a1                	li	a7,8
 ecall
     c1e:	00000073          	ecall
 ret
     c22:	8082                	ret

0000000000000c24 <link>:
.global link
link:
 li a7, SYS_link
     c24:	48cd                	li	a7,19
 ecall
     c26:	00000073          	ecall
 ret
     c2a:	8082                	ret

0000000000000c2c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     c2c:	48d1                	li	a7,20
 ecall
     c2e:	00000073          	ecall
 ret
     c32:	8082                	ret

0000000000000c34 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     c34:	48a5                	li	a7,9
 ecall
     c36:	00000073          	ecall
 ret
     c3a:	8082                	ret

0000000000000c3c <dup>:
.global dup
dup:
 li a7, SYS_dup
     c3c:	48a9                	li	a7,10
 ecall
     c3e:	00000073          	ecall
 ret
     c42:	8082                	ret

0000000000000c44 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     c44:	48ad                	li	a7,11
 ecall
     c46:	00000073          	ecall
 ret
     c4a:	8082                	ret

0000000000000c4c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     c4c:	48b1                	li	a7,12
 ecall
     c4e:	00000073          	ecall
 ret
     c52:	8082                	ret

0000000000000c54 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     c54:	48b5                	li	a7,13
 ecall
     c56:	00000073          	ecall
 ret
     c5a:	8082                	ret

0000000000000c5c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     c5c:	48b9                	li	a7,14
 ecall
     c5e:	00000073          	ecall
 ret
     c62:	8082                	ret

0000000000000c64 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     c64:	1101                	addi	sp,sp,-32
     c66:	ec06                	sd	ra,24(sp)
     c68:	e822                	sd	s0,16(sp)
     c6a:	1000                	addi	s0,sp,32
     c6c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     c70:	4605                	li	a2,1
     c72:	fef40593          	addi	a1,s0,-17
     c76:	00000097          	auipc	ra,0x0
     c7a:	f6e080e7          	jalr	-146(ra) # be4 <write>
}
     c7e:	60e2                	ld	ra,24(sp)
     c80:	6442                	ld	s0,16(sp)
     c82:	6105                	addi	sp,sp,32
     c84:	8082                	ret

0000000000000c86 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     c86:	7139                	addi	sp,sp,-64
     c88:	fc06                	sd	ra,56(sp)
     c8a:	f822                	sd	s0,48(sp)
     c8c:	f426                	sd	s1,40(sp)
     c8e:	f04a                	sd	s2,32(sp)
     c90:	ec4e                	sd	s3,24(sp)
     c92:	0080                	addi	s0,sp,64
     c94:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     c96:	c299                	beqz	a3,c9c <printint+0x16>
     c98:	0805c963          	bltz	a1,d2a <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     c9c:	2581                	sext.w	a1,a1
  neg = 0;
     c9e:	4881                	li	a7,0
     ca0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
     ca4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     ca6:	2601                	sext.w	a2,a2
     ca8:	00000517          	auipc	a0,0x0
     cac:	60050513          	addi	a0,a0,1536 # 12a8 <digits>
     cb0:	883a                	mv	a6,a4
     cb2:	2705                	addiw	a4,a4,1
     cb4:	02c5f7bb          	remuw	a5,a1,a2
     cb8:	1782                	slli	a5,a5,0x20
     cba:	9381                	srli	a5,a5,0x20
     cbc:	97aa                	add	a5,a5,a0
     cbe:	0007c783          	lbu	a5,0(a5)
     cc2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     cc6:	0005879b          	sext.w	a5,a1
     cca:	02c5d5bb          	divuw	a1,a1,a2
     cce:	0685                	addi	a3,a3,1
     cd0:	fec7f0e3          	bgeu	a5,a2,cb0 <printint+0x2a>
  if(neg)
     cd4:	00088c63          	beqz	a7,cec <printint+0x66>
    buf[i++] = '-';
     cd8:	fd070793          	addi	a5,a4,-48
     cdc:	00878733          	add	a4,a5,s0
     ce0:	02d00793          	li	a5,45
     ce4:	fef70823          	sb	a5,-16(a4)
     ce8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
     cec:	02e05863          	blez	a4,d1c <printint+0x96>
     cf0:	fc040793          	addi	a5,s0,-64
     cf4:	00e78933          	add	s2,a5,a4
     cf8:	fff78993          	addi	s3,a5,-1
     cfc:	99ba                	add	s3,s3,a4
     cfe:	377d                	addiw	a4,a4,-1
     d00:	1702                	slli	a4,a4,0x20
     d02:	9301                	srli	a4,a4,0x20
     d04:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     d08:	fff94583          	lbu	a1,-1(s2)
     d0c:	8526                	mv	a0,s1
     d0e:	00000097          	auipc	ra,0x0
     d12:	f56080e7          	jalr	-170(ra) # c64 <putc>
  while(--i >= 0)
     d16:	197d                	addi	s2,s2,-1
     d18:	ff3918e3          	bne	s2,s3,d08 <printint+0x82>
}
     d1c:	70e2                	ld	ra,56(sp)
     d1e:	7442                	ld	s0,48(sp)
     d20:	74a2                	ld	s1,40(sp)
     d22:	7902                	ld	s2,32(sp)
     d24:	69e2                	ld	s3,24(sp)
     d26:	6121                	addi	sp,sp,64
     d28:	8082                	ret
    x = -xx;
     d2a:	40b005bb          	negw	a1,a1
    neg = 1;
     d2e:	4885                	li	a7,1
    x = -xx;
     d30:	bf85                	j	ca0 <printint+0x1a>

0000000000000d32 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     d32:	7119                	addi	sp,sp,-128
     d34:	fc86                	sd	ra,120(sp)
     d36:	f8a2                	sd	s0,112(sp)
     d38:	f4a6                	sd	s1,104(sp)
     d3a:	f0ca                	sd	s2,96(sp)
     d3c:	ecce                	sd	s3,88(sp)
     d3e:	e8d2                	sd	s4,80(sp)
     d40:	e4d6                	sd	s5,72(sp)
     d42:	e0da                	sd	s6,64(sp)
     d44:	fc5e                	sd	s7,56(sp)
     d46:	f862                	sd	s8,48(sp)
     d48:	f466                	sd	s9,40(sp)
     d4a:	f06a                	sd	s10,32(sp)
     d4c:	ec6e                	sd	s11,24(sp)
     d4e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     d50:	0005c903          	lbu	s2,0(a1)
     d54:	18090f63          	beqz	s2,ef2 <vprintf+0x1c0>
     d58:	8aaa                	mv	s5,a0
     d5a:	8b32                	mv	s6,a2
     d5c:	00158493          	addi	s1,a1,1
  state = 0;
     d60:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     d62:	02500a13          	li	s4,37
     d66:	4c55                	li	s8,21
     d68:	00000c97          	auipc	s9,0x0
     d6c:	4e8c8c93          	addi	s9,s9,1256 # 1250 <malloc+0x25a>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     d70:	02800d93          	li	s11,40
  putc(fd, 'x');
     d74:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     d76:	00000b97          	auipc	s7,0x0
     d7a:	532b8b93          	addi	s7,s7,1330 # 12a8 <digits>
     d7e:	a839                	j	d9c <vprintf+0x6a>
        putc(fd, c);
     d80:	85ca                	mv	a1,s2
     d82:	8556                	mv	a0,s5
     d84:	00000097          	auipc	ra,0x0
     d88:	ee0080e7          	jalr	-288(ra) # c64 <putc>
     d8c:	a019                	j	d92 <vprintf+0x60>
    } else if(state == '%'){
     d8e:	01498d63          	beq	s3,s4,da8 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
     d92:	0485                	addi	s1,s1,1
     d94:	fff4c903          	lbu	s2,-1(s1)
     d98:	14090d63          	beqz	s2,ef2 <vprintf+0x1c0>
    if(state == 0){
     d9c:	fe0999e3          	bnez	s3,d8e <vprintf+0x5c>
      if(c == '%'){
     da0:	ff4910e3          	bne	s2,s4,d80 <vprintf+0x4e>
        state = '%';
     da4:	89d2                	mv	s3,s4
     da6:	b7f5                	j	d92 <vprintf+0x60>
      if(c == 'd'){
     da8:	11490c63          	beq	s2,s4,ec0 <vprintf+0x18e>
     dac:	f9d9079b          	addiw	a5,s2,-99
     db0:	0ff7f793          	zext.b	a5,a5
     db4:	10fc6e63          	bltu	s8,a5,ed0 <vprintf+0x19e>
     db8:	f9d9079b          	addiw	a5,s2,-99
     dbc:	0ff7f713          	zext.b	a4,a5
     dc0:	10ec6863          	bltu	s8,a4,ed0 <vprintf+0x19e>
     dc4:	00271793          	slli	a5,a4,0x2
     dc8:	97e6                	add	a5,a5,s9
     dca:	439c                	lw	a5,0(a5)
     dcc:	97e6                	add	a5,a5,s9
     dce:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
     dd0:	008b0913          	addi	s2,s6,8
     dd4:	4685                	li	a3,1
     dd6:	4629                	li	a2,10
     dd8:	000b2583          	lw	a1,0(s6)
     ddc:	8556                	mv	a0,s5
     dde:	00000097          	auipc	ra,0x0
     de2:	ea8080e7          	jalr	-344(ra) # c86 <printint>
     de6:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     de8:	4981                	li	s3,0
     dea:	b765                	j	d92 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
     dec:	008b0913          	addi	s2,s6,8
     df0:	4681                	li	a3,0
     df2:	4629                	li	a2,10
     df4:	000b2583          	lw	a1,0(s6)
     df8:	8556                	mv	a0,s5
     dfa:	00000097          	auipc	ra,0x0
     dfe:	e8c080e7          	jalr	-372(ra) # c86 <printint>
     e02:	8b4a                	mv	s6,s2
      state = 0;
     e04:	4981                	li	s3,0
     e06:	b771                	j	d92 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
     e08:	008b0913          	addi	s2,s6,8
     e0c:	4681                	li	a3,0
     e0e:	866a                	mv	a2,s10
     e10:	000b2583          	lw	a1,0(s6)
     e14:	8556                	mv	a0,s5
     e16:	00000097          	auipc	ra,0x0
     e1a:	e70080e7          	jalr	-400(ra) # c86 <printint>
     e1e:	8b4a                	mv	s6,s2
      state = 0;
     e20:	4981                	li	s3,0
     e22:	bf85                	j	d92 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
     e24:	008b0793          	addi	a5,s6,8
     e28:	f8f43423          	sd	a5,-120(s0)
     e2c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
     e30:	03000593          	li	a1,48
     e34:	8556                	mv	a0,s5
     e36:	00000097          	auipc	ra,0x0
     e3a:	e2e080e7          	jalr	-466(ra) # c64 <putc>
  putc(fd, 'x');
     e3e:	07800593          	li	a1,120
     e42:	8556                	mv	a0,s5
     e44:	00000097          	auipc	ra,0x0
     e48:	e20080e7          	jalr	-480(ra) # c64 <putc>
     e4c:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     e4e:	03c9d793          	srli	a5,s3,0x3c
     e52:	97de                	add	a5,a5,s7
     e54:	0007c583          	lbu	a1,0(a5)
     e58:	8556                	mv	a0,s5
     e5a:	00000097          	auipc	ra,0x0
     e5e:	e0a080e7          	jalr	-502(ra) # c64 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     e62:	0992                	slli	s3,s3,0x4
     e64:	397d                	addiw	s2,s2,-1
     e66:	fe0914e3          	bnez	s2,e4e <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
     e6a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
     e6e:	4981                	li	s3,0
     e70:	b70d                	j	d92 <vprintf+0x60>
        s = va_arg(ap, char*);
     e72:	008b0913          	addi	s2,s6,8
     e76:	000b3983          	ld	s3,0(s6)
        if(s == 0)
     e7a:	02098163          	beqz	s3,e9c <vprintf+0x16a>
        while(*s != 0){
     e7e:	0009c583          	lbu	a1,0(s3)
     e82:	c5ad                	beqz	a1,eec <vprintf+0x1ba>
          putc(fd, *s);
     e84:	8556                	mv	a0,s5
     e86:	00000097          	auipc	ra,0x0
     e8a:	dde080e7          	jalr	-546(ra) # c64 <putc>
          s++;
     e8e:	0985                	addi	s3,s3,1
        while(*s != 0){
     e90:	0009c583          	lbu	a1,0(s3)
     e94:	f9e5                	bnez	a1,e84 <vprintf+0x152>
        s = va_arg(ap, char*);
     e96:	8b4a                	mv	s6,s2
      state = 0;
     e98:	4981                	li	s3,0
     e9a:	bde5                	j	d92 <vprintf+0x60>
          s = "(null)";
     e9c:	00000997          	auipc	s3,0x0
     ea0:	3ac98993          	addi	s3,s3,940 # 1248 <malloc+0x252>
        while(*s != 0){
     ea4:	85ee                	mv	a1,s11
     ea6:	bff9                	j	e84 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
     ea8:	008b0913          	addi	s2,s6,8
     eac:	000b4583          	lbu	a1,0(s6)
     eb0:	8556                	mv	a0,s5
     eb2:	00000097          	auipc	ra,0x0
     eb6:	db2080e7          	jalr	-590(ra) # c64 <putc>
     eba:	8b4a                	mv	s6,s2
      state = 0;
     ebc:	4981                	li	s3,0
     ebe:	bdd1                	j	d92 <vprintf+0x60>
        putc(fd, c);
     ec0:	85d2                	mv	a1,s4
     ec2:	8556                	mv	a0,s5
     ec4:	00000097          	auipc	ra,0x0
     ec8:	da0080e7          	jalr	-608(ra) # c64 <putc>
      state = 0;
     ecc:	4981                	li	s3,0
     ece:	b5d1                	j	d92 <vprintf+0x60>
        putc(fd, '%');
     ed0:	85d2                	mv	a1,s4
     ed2:	8556                	mv	a0,s5
     ed4:	00000097          	auipc	ra,0x0
     ed8:	d90080e7          	jalr	-624(ra) # c64 <putc>
        putc(fd, c);
     edc:	85ca                	mv	a1,s2
     ede:	8556                	mv	a0,s5
     ee0:	00000097          	auipc	ra,0x0
     ee4:	d84080e7          	jalr	-636(ra) # c64 <putc>
      state = 0;
     ee8:	4981                	li	s3,0
     eea:	b565                	j	d92 <vprintf+0x60>
        s = va_arg(ap, char*);
     eec:	8b4a                	mv	s6,s2
      state = 0;
     eee:	4981                	li	s3,0
     ef0:	b54d                	j	d92 <vprintf+0x60>
    }
  }
}
     ef2:	70e6                	ld	ra,120(sp)
     ef4:	7446                	ld	s0,112(sp)
     ef6:	74a6                	ld	s1,104(sp)
     ef8:	7906                	ld	s2,96(sp)
     efa:	69e6                	ld	s3,88(sp)
     efc:	6a46                	ld	s4,80(sp)
     efe:	6aa6                	ld	s5,72(sp)
     f00:	6b06                	ld	s6,64(sp)
     f02:	7be2                	ld	s7,56(sp)
     f04:	7c42                	ld	s8,48(sp)
     f06:	7ca2                	ld	s9,40(sp)
     f08:	7d02                	ld	s10,32(sp)
     f0a:	6de2                	ld	s11,24(sp)
     f0c:	6109                	addi	sp,sp,128
     f0e:	8082                	ret

0000000000000f10 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     f10:	715d                	addi	sp,sp,-80
     f12:	ec06                	sd	ra,24(sp)
     f14:	e822                	sd	s0,16(sp)
     f16:	1000                	addi	s0,sp,32
     f18:	e010                	sd	a2,0(s0)
     f1a:	e414                	sd	a3,8(s0)
     f1c:	e818                	sd	a4,16(s0)
     f1e:	ec1c                	sd	a5,24(s0)
     f20:	03043023          	sd	a6,32(s0)
     f24:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
     f28:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
     f2c:	8622                	mv	a2,s0
     f2e:	00000097          	auipc	ra,0x0
     f32:	e04080e7          	jalr	-508(ra) # d32 <vprintf>
}
     f36:	60e2                	ld	ra,24(sp)
     f38:	6442                	ld	s0,16(sp)
     f3a:	6161                	addi	sp,sp,80
     f3c:	8082                	ret

0000000000000f3e <printf>:

void
printf(const char *fmt, ...)
{
     f3e:	711d                	addi	sp,sp,-96
     f40:	ec06                	sd	ra,24(sp)
     f42:	e822                	sd	s0,16(sp)
     f44:	1000                	addi	s0,sp,32
     f46:	e40c                	sd	a1,8(s0)
     f48:	e810                	sd	a2,16(s0)
     f4a:	ec14                	sd	a3,24(s0)
     f4c:	f018                	sd	a4,32(s0)
     f4e:	f41c                	sd	a5,40(s0)
     f50:	03043823          	sd	a6,48(s0)
     f54:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     f58:	00840613          	addi	a2,s0,8
     f5c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
     f60:	85aa                	mv	a1,a0
     f62:	4505                	li	a0,1
     f64:	00000097          	auipc	ra,0x0
     f68:	dce080e7          	jalr	-562(ra) # d32 <vprintf>
}
     f6c:	60e2                	ld	ra,24(sp)
     f6e:	6442                	ld	s0,16(sp)
     f70:	6125                	addi	sp,sp,96
     f72:	8082                	ret

0000000000000f74 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     f74:	1141                	addi	sp,sp,-16
     f76:	e422                	sd	s0,8(sp)
     f78:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
     f7a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f7e:	00001797          	auipc	a5,0x1
     f82:	0827b783          	ld	a5,130(a5) # 2000 <freep>
     f86:	a02d                	j	fb0 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
     f88:	4618                	lw	a4,8(a2)
     f8a:	9f2d                	addw	a4,a4,a1
     f8c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
     f90:	6398                	ld	a4,0(a5)
     f92:	6310                	ld	a2,0(a4)
     f94:	a83d                	j	fd2 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
     f96:	ff852703          	lw	a4,-8(a0)
     f9a:	9f31                	addw	a4,a4,a2
     f9c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     f9e:	ff053683          	ld	a3,-16(a0)
     fa2:	a091                	j	fe6 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fa4:	6398                	ld	a4,0(a5)
     fa6:	00e7e463          	bltu	a5,a4,fae <free+0x3a>
     faa:	00e6ea63          	bltu	a3,a4,fbe <free+0x4a>
{
     fae:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fb0:	fed7fae3          	bgeu	a5,a3,fa4 <free+0x30>
     fb4:	6398                	ld	a4,0(a5)
     fb6:	00e6e463          	bltu	a3,a4,fbe <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fba:	fee7eae3          	bltu	a5,a4,fae <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
     fbe:	ff852583          	lw	a1,-8(a0)
     fc2:	6390                	ld	a2,0(a5)
     fc4:	02059813          	slli	a6,a1,0x20
     fc8:	01c85713          	srli	a4,a6,0x1c
     fcc:	9736                	add	a4,a4,a3
     fce:	fae60de3          	beq	a2,a4,f88 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
     fd2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
     fd6:	4790                	lw	a2,8(a5)
     fd8:	02061593          	slli	a1,a2,0x20
     fdc:	01c5d713          	srli	a4,a1,0x1c
     fe0:	973e                	add	a4,a4,a5
     fe2:	fae68ae3          	beq	a3,a4,f96 <free+0x22>
    p->s.ptr = bp->s.ptr;
     fe6:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
     fe8:	00001717          	auipc	a4,0x1
     fec:	00f73c23          	sd	a5,24(a4) # 2000 <freep>
}
     ff0:	6422                	ld	s0,8(sp)
     ff2:	0141                	addi	sp,sp,16
     ff4:	8082                	ret

0000000000000ff6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
     ff6:	7139                	addi	sp,sp,-64
     ff8:	fc06                	sd	ra,56(sp)
     ffa:	f822                	sd	s0,48(sp)
     ffc:	f426                	sd	s1,40(sp)
     ffe:	f04a                	sd	s2,32(sp)
    1000:	ec4e                	sd	s3,24(sp)
    1002:	e852                	sd	s4,16(sp)
    1004:	e456                	sd	s5,8(sp)
    1006:	e05a                	sd	s6,0(sp)
    1008:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    100a:	02051493          	slli	s1,a0,0x20
    100e:	9081                	srli	s1,s1,0x20
    1010:	04bd                	addi	s1,s1,15
    1012:	8091                	srli	s1,s1,0x4
    1014:	0014899b          	addiw	s3,s1,1
    1018:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    101a:	00001517          	auipc	a0,0x1
    101e:	fe653503          	ld	a0,-26(a0) # 2000 <freep>
    1022:	c515                	beqz	a0,104e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1024:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1026:	4798                	lw	a4,8(a5)
    1028:	02977f63          	bgeu	a4,s1,1066 <malloc+0x70>
    102c:	8a4e                	mv	s4,s3
    102e:	0009871b          	sext.w	a4,s3
    1032:	6685                	lui	a3,0x1
    1034:	00d77363          	bgeu	a4,a3,103a <malloc+0x44>
    1038:	6a05                	lui	s4,0x1
    103a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    103e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1042:	00001917          	auipc	s2,0x1
    1046:	fbe90913          	addi	s2,s2,-66 # 2000 <freep>
  if(p == (char*)-1)
    104a:	5afd                	li	s5,-1
    104c:	a895                	j	10c0 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
    104e:	00001797          	auipc	a5,0x1
    1052:	fc278793          	addi	a5,a5,-62 # 2010 <base>
    1056:	00001717          	auipc	a4,0x1
    105a:	faf73523          	sd	a5,-86(a4) # 2000 <freep>
    105e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1060:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    1064:	b7e1                	j	102c <malloc+0x36>
      if(p->s.size == nunits)
    1066:	02e48c63          	beq	s1,a4,109e <malloc+0xa8>
        p->s.size -= nunits;
    106a:	4137073b          	subw	a4,a4,s3
    106e:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1070:	02071693          	slli	a3,a4,0x20
    1074:	01c6d713          	srli	a4,a3,0x1c
    1078:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    107a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    107e:	00001717          	auipc	a4,0x1
    1082:	f8a73123          	sd	a0,-126(a4) # 2000 <freep>
      return (void*)(p + 1);
    1086:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    108a:	70e2                	ld	ra,56(sp)
    108c:	7442                	ld	s0,48(sp)
    108e:	74a2                	ld	s1,40(sp)
    1090:	7902                	ld	s2,32(sp)
    1092:	69e2                	ld	s3,24(sp)
    1094:	6a42                	ld	s4,16(sp)
    1096:	6aa2                	ld	s5,8(sp)
    1098:	6b02                	ld	s6,0(sp)
    109a:	6121                	addi	sp,sp,64
    109c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    109e:	6398                	ld	a4,0(a5)
    10a0:	e118                	sd	a4,0(a0)
    10a2:	bff1                	j	107e <malloc+0x88>
  hp->s.size = nu;
    10a4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    10a8:	0541                	addi	a0,a0,16
    10aa:	00000097          	auipc	ra,0x0
    10ae:	eca080e7          	jalr	-310(ra) # f74 <free>
  return freep;
    10b2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    10b6:	d971                	beqz	a0,108a <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10b8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    10ba:	4798                	lw	a4,8(a5)
    10bc:	fa9775e3          	bgeu	a4,s1,1066 <malloc+0x70>
    if(p == freep)
    10c0:	00093703          	ld	a4,0(s2)
    10c4:	853e                	mv	a0,a5
    10c6:	fef719e3          	bne	a4,a5,10b8 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
    10ca:	8552                	mv	a0,s4
    10cc:	00000097          	auipc	ra,0x0
    10d0:	b80080e7          	jalr	-1152(ra) # c4c <sbrk>
  if(p == (char*)-1)
    10d4:	fd5518e3          	bne	a0,s5,10a4 <malloc+0xae>
        return 0;
    10d8:	4501                	li	a0,0
    10da:	bf45                	j	108a <malloc+0x94>
