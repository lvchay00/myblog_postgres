-- MySQL dump 10.13  Distrib 5.7.23, for Win64 (x86_64)
--
-- Host: 104.224.163.70    Database: blog-go
-- ------------------------------------------------------
-- Server version	5.7.23-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section`
--

LOCK TABLES `section` WRITE;
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
INSERT INTO `section` VALUES (7,'android'),(3,'C# .NET'),(1,'golang'),(8,'html 前端'),(5,'linux'),(6,'python'),(2,'嵌入式软硬件'),(4,'数据库相关');
/*!40000 ALTER TABLE `section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic`
--

DROP TABLE IF EXISTS `topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `content` longtext,
  `in_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL,
  `view` int(11) NOT NULL DEFAULT '0',
  `reply_count` int(11) NOT NULL DEFAULT '0',
  `last_reply_user_id` int(11) DEFAULT NULL,
  `last_reply_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic`
--

LOCK TABLES `topic` WRITE;
/*!40000 ALTER TABLE `topic` DISABLE KEYS */;
INSERT INTO `topic` VALUES (26,'os.Mkdir 等文件读写权限','\r\n当我试图使用os.Mkdir 创建文件夹时，怎么配置第2个参数？\r\n经查资料得知，golang和Linux的文件权限配置相同。\r\n\r\n例如 os.Mkdir(\"dirname\", 0777)\r\n###### 许可位\r\n\r\n\r\n```\r\n-   | rwx | 7 | Read, write and execute  |\r\n-   | rw- | 6 | Read, write              |\r\n-   | r-x | 5 | Read, and execute        |\r\n-   | r-- | 4 | Read,                    |\r\n-   | -wx | 3 | Write and execute        |\r\n-   | -w- | 2 | Write                    |\r\n-   | --x | 1 | Execute                  |\r\n-   | --- | 0 | no permissions           |\r\n-   +------------------------------------+\r\n-   \r\n-   +------------+------+-------+\r\n-   | Permission | Octal| Field |\r\n-   +------------+------+-------+\r\n-   | rwx------  | 0700 | User  |\r\n-   | ---rwx---  | 0070 | Group |\r\n-   | ------rwx  | 0007 | Other |\r\n-   +------------+------+-------+\r\n```\r\n\r\n\r\n##### 我们经常使用的权限\r\n###### 0755常用于Web服务器。所有者可以读，写，执行。其他人都可以读取和执行但不修改文件。\r\n\r\n###### 0777每个人都可以读写和执行。在网络服务器上，不建议对文件和文件夹使用“777”权限，因为它允许任何人向服务器添加恶意代码\r\n\r\n###### 0644只有拥有者才能读写。别人都只能读。没有人可以执行文件。\r\n\r\n###### 0655只有所有者才能读写，但不能执行文件。其他人都可以读取和执行，但无法修改文件。\r\n\r\n##### **权限计算器**http://permissions-calculator.org/\r\n\r\n![image](/static/blog/文件读写权限/QQ拼音截图20180809085812.jpg)\r\n','2018-08-09 11:27:38',4,1,10,0,NULL,'2018-08-09 11:27:38'),(27,' 结构体标签（struct tag ）反射 解析json','在Go语言当中，好多功能都使用了结构体标签。主要应用在encoding/json和encoding/xml之中。那么我们先用Json的使用做一个例子。首先创建一个结构体。\r\n\r\n\r\n```\r\ntype User struct {\r\n	Name      string    `json:\"name\"`\r\n	Bio       string    `json:\"about,omitempty\"`\r\n	Admin     bool      `json:\"-\"`\r\n	CreatedAt time.Time `json:\"created_at\"`\r\n}\r\n```\r\n\r\n\r\n\r\n结构体的字段除了名字和类型外，还可以有一个可选的标签（tag），类型后面的那串字符串，就是标签，它是一个附属于字段的字符串，可以是文档或其他的重要标记。例如在json中 omitempty标签可以在序列化的时候忽略0值或者空值。而 - 标签的作用是不进行序列化。\r\n\r\n\r\n在没有使用结构体表情的情况下，我们使用json.Marshal进行处理后输出的是这样的，和结构体所定义的结构成员的名称是一致的。\r\n\r\n```\r\n{\r\n  \"Name\":\"Jobs\",\r\n  \"Bio\":\"\",\r\n  \"Admin\":false,\r\n  \"CreatedAt\":\"0001-01-01T00:00:00Z\"\r\n}\r\n```\r\n\r\n\r\n当我们使用结构体标签后，可以很清晰的看到，结构体标签上的json后面的那段字符串，成为了Json中的Key值(omitempty忽略0值或者空值,而 - 标签没有输出),它是通过包反射进行获取结构体的标签名实现的。\r\n\r\n\r\n```\r\n{\r\n \"name\":\"Jobs\",\r\n \"created_at\":\"0001-01-01T00:00:00Z\"\r\n}\r\n```\r\n\r\n\r\n反射获取结构体的标签名实现：\r\n\r\n```\r\npackage main\r\n\r\nimport (\r\n    \"fmt\"\r\n    \"reflect\"\r\n)\r\n\r\nconst tagName = \"Testing\"\r\n\r\ntype Info struct {\r\n    Name string `Testing:\"-\"`\r\n    Age  int    `Testing:\"age,min=17,max=60\"`\r\n    Sex  string `Testing:\"sex,required\"`\r\n}\r\n\r\nfunc main() {\r\n    info := Info{\r\n        Name: \"benben\",\r\n        Age:  23,\r\n        Sex:  \"male\",\r\n    }\r\n\r\n    //通过反射，我们获取变量的动态类型\r\n    t := reflect.TypeOf(info)\r\n    fmt.Println(\"Type:\", t.Name())\r\n    fmt.Println(\"Kind:\", t.Kind())\r\n\r\n    for i := 0; i < t.NumField(); i++ {\r\n        field := t.Field(i) //获取结构体的每一个字段\r\n        tag := field.Tag.Get(tagName)\r\n        //序号，字段名（字段类型），字段标签\r\n        fmt.Printf(\"%d. %v (%v), tag: \'%v\'\\n\", i+1, field.Name, field.Type.Name(), tag)\r\n    }\r\n}\r\n```\r\n\r\n先导入了reflect这个包，然后使用reflect中的TypeOf获取变量的动态类型，遍历结构体程序，通过.Tag.Get方法获取结构体的每一个成员的标签。输出：\r\n\r\n```\r\nType: Info\r\nKind: struct\r\n1. Name (string), tag: \'-\'\r\n2. Age (int), tag: \'age,min=17,max=60\'\r\n3. Sex (string), tag: \'sex,required\'\r\n```','2018-08-11 04:55:02',4,1,51,0,NULL,'2018-08-11 04:55:02'),(28,'彻底理解cookie，session，token','文章来源：http://www.cnblogs.com/moyand/\r\n##### 发展史\r\n 1、很久很久以前，Web 基本上就是文档的浏览而已， 既然是浏览，作为服务器， 不需要记录谁在某一段时间里都浏览了什么文档，每次请求都是一个新的HTTP协议， 就是请求加响应，  尤其是我不用记住是谁刚刚发了HTTP请求，   每个请求对我来说都是全新的。这段时间很嗨皮\r\n\r\n2、但是随着交互式Web应用的兴起，像在线购物网站，需要登录的网站等等，马上就面临一个问题，那就是要管理会话，必须记住哪些人登录系统，  哪些人往自己的购物车中放商品，  也就是说我必须把每个人区分开，这就是一个不小的挑战，因为HTTP请求是无状态的，所以想出的办法就是给大家发一个会话标识(session id), 说白了就是一个随机的字串，每个人收到的都不一样，  每次大家向我发起HTTP请求的时候，把这个字符串给一并捎过来， 这样我就能区分开谁是谁了\r\n\r\n3、这样大家很嗨皮了，可是服务器就不嗨皮了，每个人只需要保存自己的session id，而服务器要保存所有人的session id ！  如果访问服务器多了， 就得由成千上万，甚至几十万个。\r\n\r\n这对服务器说是一个巨大的开销 ， 严重的限制了服务器扩展能力， 比如说我用两个机器组成了一个集群， 小F通过机器A登录了系统，  那session id会保存在机器A上，  假设小F的下一次请求被转发到机器B怎么办？  机器B可没有小F的 session id啊。\r\n\r\n有时候会采用一点小伎俩： session sticky ， 就是让小F的请求一直粘连在机器A上， 但是这也不管用， 要是机器A挂掉了， 还得转到机器B去。\r\n\r\n那只好做session 的复制了， 把session id  在两个机器之间搬来搬去， 快累死了。\r\n\r\n![image](/static/blog/彻底理解cookie，session，token/1.png)　　　　　　\r\n\r\n后来有个叫Memcached的支了招： 把session id 集中存储到一个地方， 所有的机器都来访问这个地方的数据， 这样一来，就不用复制了， 但是增加了单点失败的可能性， 要是那个负责session 的机器挂了，  所有人都得重新登录一遍， 估计得被人骂死。\r\n\r\n![image](/static/blog/彻底理解cookie，session，token/2.png)\r\n　　　　　　  \r\n\r\n也尝试把这个单点的机器也搞出集群，增加可靠性， 但不管如何， 这小小的session 对我来说是一个沉重的负担\r\n\r\n \r\n\r\n4 于是有人就一直在思考， 我为什么要保存这可恶的session呢， 只让每个客户端去保存该多好？\r\n\r\n \r\n\r\n可是如果不保存这些session id ,  怎么验证客户端发给我的session id 的确是我生成的呢？  如果不去验证，我们都不知道他们是不是合法登录的用户， 那些不怀好意的家伙们就可以伪造session id , 为所欲为了。\r\n\r\n \r\n\r\n嗯，对了，关键点就是验证 ！\r\n\r\n \r\n\r\n比如说， 小F已经登录了系统， 我给他发一个令牌(token)， 里边包含了小F的 user id， 下一次小F 再次通过Http 请求访问我的时候， 把这个token 通过Http header 带过来不就可以了。\r\n\r\n \r\n\r\n不过这和session id没有本质区别啊， 任何人都可以可以伪造，  所以我得想点儿办法， 让别人伪造不了。\r\n\r\n \r\n\r\n那就对数据做一个签名吧， 比如说我用HMAC-SHA256 算法，加上一个只有我才知道的密钥，  对数据做一个签名， 把这个签名和数据一起作为token ，   由于密钥别人不知道， 就无法伪造token了。\r\n\r\n![image](/static/blog/彻底理解cookie，session，token/3.png)\r\n\r\n\r\n这个token 我不保存，  当小F把这个token 给我发过来的时候，我再用同样的HMAC-SHA256 算法和同样的密钥，对数据再计算一次签名， 和token 中的签名做个比较， 如果相同， 我就知道小F已经登录过了，并且可以直接取到小F的user id ,  如果不相同， 数据部分肯定被人篡改过， 我就告诉发送者： 对不起，没有认证。\r\n\r\n![image](/static/blog/彻底理解cookie，session，token/4.png)\r\n\r\nToken 中的数据是明文保存的（虽然我会用Base64做下编码， 但那不是加密）， 还是可以被别人看到的， 所以我不能在其中保存像密码这样的敏感信息。\r\n\r\n \r\n\r\n当然， 如果一个人的token 被别人偷走了， 那我也没办法， 我也会认为小偷就是合法用户， 这其实和一个人的session id 被别人偷走是一样的。\r\n\r\n \r\n\r\n这样一来， 我就不保存session id 了， 我只是生成token , 然后验证token ，  我用我的CPU计算时间获取了我的session 存储空间 ！\r\n\r\n \r\n\r\n解除了session id这个负担，  可以说是无事一身轻， 我的机器集群现在可以轻松地做水平扩展， 用户访问量增大， 直接加机器就行。   这种无状态的感觉实在是太好了！\r\n\r\nCookie\r\ncookie 是一个非常具体的东西，指的就是浏览器里面能永久存储的一种数据，仅仅是浏览器实现的一种数据存储功能。\r\n\r\ncookie由服务器生成，发送给浏览器，浏览器把cookie以kv形式保存到某个目录下的文本文件内，下一次请求同一网站时会把该cookie发送给服务器。由于cookie是存在客户端上的，所以浏览器加入了一些限制确保cookie不会被恶意使用，同时不会占据太多磁盘空间，所以每个域的cookie数量是有限的。\r\n\r\nSession\r\nsession 从字面上讲，就是会话。这个就类似于你和一个人交谈，你怎么知道当前和你交谈的是张三而不是李四呢？对方肯定有某种特征（长相等）表明他就是张三。\r\n\r\nsession 也是类似的道理，服务器要知道当前发请求给自己的是谁。为了做这种区分，服务器就要给每个客户端分配不同的“身份标识”，然后客户端每次向服务器发请求的时候，都带上这个“身份标识”，服务器就知道这个请求来自于谁了。至于客户端怎么保存这个“身份标识”，可以有很多种方式，对于浏览器客户端，大家都默认采用 cookie 的方式。\r\n\r\n服务器使用session把用户的信息临时保存在了服务器上，用户离开网站后session会被销毁。这种用户信息存储方式相对cookie来说更安全，可是session有一个缺陷：如果web服务器做了负载均衡，那么下一个操作请求到了另一台服务器的时候session会丢失。\r\n\r\nToken\r\n在Web领域基于Token的身份验证随处可见。在大多数使用Web API的互联网公司中，tokens 是多用户下处理认证的最佳方式。\r\n\r\n以下几点特性会让你在程序中使用基于Token的身份验证\r\n\r\n1.无状态、可扩展\r\n\r\n 2.支持移动设备\r\n\r\n 3.跨程序调用\r\n\r\n 4.安全\r\n\r\n \r\n\r\n那些使用基于Token的身份验证的大佬们\r\n\r\n大部分你见到过的API和Web应用都使用tokens。例如Facebook, Twitter, Google+, GitHub等。\r\n\r\n \r\n\r\nToken的起源\r\n\r\n在介绍基于Token的身份验证的原理与优势之前，不妨先看看之前的认证都是怎么做的。\r\n\r\n　　基于服务器的验证\r\n\r\n　  我们都是知道HTTP协议是无状态的，这种无状态意味着程序需要验证每一次请求，从而辨别客户端的身份。\r\n\r\n在这之前，程序都是通过在服务端存储的登录信息来辨别请求的。这种方式一般都是通过存储Session来完成。\r\n\r\n下图展示了基于服务器验证的原理\r\n\r\n \r\n\r\n随着Web，应用程序，已经移动端的兴起，这种验证的方式逐渐暴露出了问题。尤其是在可扩展性方面。\r\n\r\n \r\n\r\n基于服务器验证方式暴露的一些问题\r\n\r\n1.Seesion：每次认证用户发起请求时，服务器需要去创建一个记录来存储信息。当越来越多的用户发请求时，内存的开销也会不断增加。\r\n\r\n2.可扩展性：在服务端的内存中使用Seesion存储登录信息，伴随而来的是可扩展性问题。\r\n\r\n3.CORS(跨域资源共享)：当我们需要让数据跨多台移动设备上使用时，跨域资源的共享会是一个让人头疼的问题。在使用Ajax抓取另一个域的资源，就可以会出现禁止请求的情况。\r\n\r\n4.CSRF(跨站请求伪造)：用户在访问银行网站时，他们很容易受到跨站请求伪造的攻击，并且能够被利用其访问其他的网站。\r\n\r\n在这些问题中，可扩展行是最突出的。因此我们有必要去寻求一种更有行之有效的方法。\r\n\r\n \r\n\r\n基于Token的验证原理\r\n\r\n基于Token的身份验证是无状态的，我们不将用户信息存在服务器或Session中。\r\n\r\n这种概念解决了在服务端存储信息时的许多问题\r\n\r\n　　NoSession意味着你的程序可以根据需要去增减机器，而不用去担心用户是否登录。\r\n\r\n基于Token的身份验证的过程如下:\r\n\r\n1.用户通过用户名和密码发送请求。\r\n\r\n2.程序验证。\r\n\r\n3.程序返回一个签名的token 给客户端。\r\n\r\n4.客户端储存token,并且每次用于每次发送请求。\r\n\r\n5.服务端验证token并返回数据。\r\n\r\n 每一次请求都需要token。token应该在HTTP的头部发送从而保证了Http请求无状态。我们同样通过设置服务器属性Access-Control-Allow-Origin:* ，让服务器能接受到来自所有域的请求。需要主要的是，在ACAO头部标明(designating)*时，不得带有像HTTP认证，客户端SSL证书和cookies的证书。\r\n\r\n  实现思路：\r\n\r\n![image](/static/blog/彻底理解cookie，session，token/1.png)\r\n\r\n1.用户登录校验，校验成功后就返回Token给客户端。\r\n\r\n2.客户端收到数据后保存在客户端\r\n\r\n3.客户端每次访问API是携带Token到服务器端。\r\n\r\n4.服务器端采用filter过滤器校验。校验成功则返回请求数据，校验失败则返回错误码\r\n\r\n \r\n\r\n \r\n\r\n当我们在程序中认证了信息并取得token之后，我们便能通过这个Token做许多的事情。\r\n\r\n我们甚至能基于创建一个基于权限的token传给第三方应用程序，这些第三方程序能够获取到我们的数据（当然只有在我们允许的特定的token）\r\n\r\n \r\n\r\nTokens的优势\r\n\r\n无状态、可扩展\r\n\r\n在客户端存储的Tokens是无状态的，并且能够被扩展。基于这种无状态和不存储Session信息，负载负载均衡器能够将用户信息从一个服务传到其他服务器上。\r\n\r\n如果我们将已验证的用户的信息保存在Session中，则每次请求都需要用户向已验证的服务器发送验证信息(称为Session亲和性)。用户量大时，可能会造成\r\n\r\n 一些拥堵。\r\n\r\n但是不要着急。使用tokens之后这些问题都迎刃而解，因为tokens自己hold住了用户的验证信息。\r\n\r\n安全性\r\n\r\n请求中发送token而不再是发送cookie能够防止CSRF(跨站请求伪造)。即使在客户端使用cookie存储token，cookie也仅仅是一个存储机制而不是用于认证。不将信息存储在Session中，让我们少了对session操作。 \r\n\r\ntoken是有时效的，一段时间之后用户需要重新验证。我们也不一定需要等到token自动失效，token有撤回的操作，通过token revocataion可以使一个特定的token或是一组有相同认证的token无效。\r\n\r\n可扩展性（）\r\n\r\nTokens能够创建与其它程序共享权限的程序。例如，能将一个随便的社交帐号和自己的大号(Fackbook或是Twitter)联系起来。当通过服务登录Twitter(我们将这个过程Buffer)时，我们可以将这些Buffer附到Twitter的数据流上(we are allowing Buffer to post to our Twitter stream)。\r\n\r\n使用tokens时，可以提供可选的权限给第三方应用程序。当用户想让另一个应用程序访问它们的数据，我们可以通过建立自己的API，得出特殊权限的tokens。\r\n\r\n多平台跨域\r\n\r\n我们提前先来谈论一下CORS(跨域资源共享)，对应用程序和服务进行扩展的时候，需要介入各种各种的设备和应用程序。\r\n\r\nHaving our API just serve data, we can also make the design choice to serve assets from a CDN. This eliminates the issues that CORS brings up after we set a quick header configuration for our application.\r\n\r\n只要用户有一个通过了验证的token，数据和资源就能够在任何域上被请求到。\r\n\r\n          Access-Control-Allow-Origin: *       \r\n基于标准\r\n\r\n创建token的时候，你可以设定一些选项。我们在后续的文章中会进行更加详尽的描述，但是标准的用法会在JSON Web Tokens体现。\r\n\r\n最近的程序和文档是供给JSON Web Tokens的。它支持众多的语言。这意味在未来的使用中你可以真正的转换你的认证机制。\r\n','2018-08-10 05:15:07',4,8,14,0,NULL,'2018-08-10 05:15:07'),(29,'golang 操作mysql(增删查改)','```\r\npackage main\r\nimport (\r\n    \"database/sql\"\r\n    \"fmt\"\r\n    //\"time\"\r\n\r\n    _ \"github.com/go-sql-driver/mysql\"\r\n)\r\n```\r\n\r\n```\r\n//选择 查询数据\r\n//参数： 数据库 表 字段 内容\r\nfunc selectData(db *sql.DB, table string, name string, str string) {\r\n\r\n    fmt.Println(\"查询数据 \" + table + \"  \" + name + \"  \" + str + \"\\n\")\r\n    var rows *sql.Rows\r\n    var err error\r\n    if table == \"\" {\r\n        return\r\n    } else if name == \"\" {\r\n        fmt.Println(\"SELECT * From \" + table + \"\\n\")\r\n        rows, err = db.Query(\"SELECT * From \" + table)\r\n    } else if str == \"\" {\r\n        fmt.Println(\"SELECT * From \" + table + \"\\n\")\r\n        rows, err = db.Query(\"SELECT * From \" + table)\r\n    } else {\r\n        rows, err = db.Query(\"SELECT * From \" + table + \" where \" + name + \" =\'\" + str + \"\'\"\r\n    }\r\n\r\n    if err != nil {\r\n        fmt.Printf(\"insert data error: %v\\n\", err)\r\n        return\r\n    }\r\n\r\n    cloumns, err := rows.Columns()\r\n    if err != nil {\r\n        fmt.Println(err)\r\n    }\r\n    values := make([]sql.RawBytes, len(cloumns))\r\n    scanArgs := make([]interface{}, len(values))\r\n    for i := range values {\r\n        scanArgs[i] = &values[i]\r\n    }\r\n    for rows.Next() {\r\n        err = rows.Scan(scanArgs...)\r\n        if err != nil {\r\n            fmt.Println(err)\r\n        }\r\n        for i, col := range values {\r\n            fmt.Printf(\"%s: %s\\n\", cloumns[i], col)\r\n        }\r\n    }\r\n    err = rows.Err()\r\n    if err != nil {\r\n        fmt.Println(err)\r\n    }\r\n    defer fmt.Printf(\"查询数据完成..................\\n\")\r\n}\r\n```\r\n\r\n\r\n\r\n```\r\n//删除数据\r\nfunc deleteData(db *sql.DB, table string, name string, str string) {\r\n\r\n    fmt.Println(\"删除数据 \" + table + \"  \" + name + \"  \" + str + \"\\n\")\r\n    stmt, err := db.Prepare(\"delete from \" + table + \" where \" + name + \"=?\")\r\n    checkErr(err)\r\n\r\n    res, err := stmt.Exec(str)\r\n    checkErr(err)\r\n\r\n    affect, err := res.RowsAffected()\r\n    checkErr(err)\r\n\r\n    fmt.Println(affect)\r\n    defer fmt.Println(\"删除数据完成.....................\\n\")\r\n}\r\n```\r\n\r\n\r\n\r\n```\r\n//更新数据\r\n//参数： 数据库 表 设置的字段 设置的内容 目标位置字段  目标位置内容\r\nfunc updataData(db *sql.DB, table string, setName string, setStr string, targetName string, targetStr string) {\r\n\r\n    //更新数据\r\n    fmt.Println(\"更新数据 \" + table + \"  \" + setName + \"  \" + setStr + \"\\n\")\r\n    stmt, err := db.Prepare(\"update \" + table + \" set \" + setName + \"=? where \" + targetName + \"=?\")\r\n    checkErr(err)\r\n\r\n    res, err := stmt.Exec(setStr, targetStr)\r\n    checkErr(err)\r\n\r\n    affect, err := res.RowsAffected()\r\n    checkErr(err)\r\n\r\n    fmt.Println(affect)\r\n    defer fmt.Println(\"更新数据.....................\\n\")\r\n}\r\n```\r\n\r\n\r\n\r\n```\r\nfunc main() {\r\n    //连接\r\n    db, err := sql.Open(\"mysql\", \"root:@test?charset=utf8\")\r\n    checkErr(err)\r\n\r\n    //插入数据\r\n    stmt, err := db.Prepare(\"INSERT userinfo SET username=?,department=?,created=?\")\r\n    checkErr(err)\r\n    res, err := stmt.Exec(\"golang\", \"语言\", \"2009-12-09\")\r\n    checkErr(err)\r\n    //查询\r\n    selectData(db, \"userinfo\", \"\", \"\")\r\n\r\n    uid, err := res.LastInsertId()\r\n    checkErr(err)\r\n    fmt.Println(uid)\r\n\r\n    //查询\r\n    selectData(db, \"userinfo\", \"\", \"\")\r\n    //更新\r\n    updataData(db, \"userinfo\", \"username\", \"updata\", \"department\", \"语言\")\r\n    //查询\r\n    selectData(db, \"userinfo\", \"username\", \"updata\")\r\n    //删除\r\n    deleteData(db, \"userinfo\", \"username\", \"updata\")\r\n    //查询\r\n    selectData(db, \"userinfo\", \"\", \"\")\r\n\r\n    db.Close()\r\n\r\n}\r\n```\r\n\r\n\r\n\r\n```\r\nfunc checkErr(err error) {\r\n    if err != nil {\r\n        panic(err)\r\n    }\r\n}\r\n```\r\n','2018-08-10 14:15:11',4,1,10,0,NULL,'2018-08-10 14:15:11'),(30,'MySQL Workbench导出数据库','MySQL Workbench导出数据库\r\n\r\n步骤：\r\n1. 打开mysql workbench，进入需要导出的数据库\r\n\r\n![image](/static/blog/MySQL Workbench/1.png)\r\n\r\n2. 点选要输出的数据库,点击【Data Export】选在要输出的数据库,选择是否输出存储过程和函数.事件.触发器 ,点击Start Export\r\n\r\n![image](/static/blog/MySQL Workbench/2.png)\r\n \r\n3. 导出成功\r\n\r\n ![image](/static/blog/MySQL Workbench/3.png)\r\n\r\n导出错误处理：\r\n（mysqldump.exe 版本对应不上）\r\n\r\n![image](/static/blog/MySQL Workbench/4.png)\r\n\r\n上官网下载对应版本 mysql,然后解压\r\n\r\n![image](/static/blog/MySQL Workbench/5.png)\r\n\r\n设置workbench\r\n\r\n![image](/static/blog/MySQL Workbench/6.png)','2018-08-10 06:42:21',4,4,7,0,NULL,'2018-08-10 06:42:21'),(31,'orm库 操作mysql','ORM, 即Object-Relational Mapping(对象关系映射)，它的作用是在关系型数据库和业务实体对象之间作一个映射，这样在具体的操作业务对象的时候，就不需要再去和复杂的SQL语句打交道，只需简单的操作对象的属性和方法。\r\n\r\nbeego ORM 是一个强大的 Go 语言 ORM 框架，orm模块主要是处理MVC中的M（models）\r\n\r\n下面是使用ORM的简单例子，比使用sql语句简单了很多\r\n\r\n```\r\npackage main\r\n\r\nimport (\r\n    \"fmt\"\r\n    \"github.com/astaxie/beego/orm\"\r\n    _ \"github.com/go-sql-driver/mysql\" \r\n)\r\n\r\n// Model Struct\r\ntype User struct {\r\n    Id   int\r\n    Name string `orm:\"size(100)\"`\r\n}\r\n\r\nfunc init() {\r\n    // 设置默认数据库\r\n    orm.RegisterDataBase(\"default\", \"mysql\", \"root:@tcp/test?charset=utf8\", 30)\r\n\r\n    // 注册定义的 model\r\n    orm.RegisterModel(new(User))\r\n    //RegisterModel 也可以同时注册多个 model\r\n    //orm.RegisterModel(new(User), new(Profile), new(Post))\r\n\r\n    // 创建 table\r\n    orm.RunSyncdb(\"default\", false, true)\r\n}\r\n\r\nfunc main() {\r\n    o := orm.NewOrm()\r\n\r\n    user := User{Name: \"slene\"}\r\n\r\n    // 插入表\r\n    id, err := o.Insert(&user)\r\n    fmt.Printf(\"ID: %d, ERR: %v\\n\", id, err)\r\n\r\n    // 更新表\r\n    user.Name = \"astaxie\"\r\n    num, err := o.Update(&user)\r\n    fmt.Printf(\"NUM: %d, ERR: %v\\n\", num, err)\r\n\r\n    // 读取 one\r\n    u := User{Id: user.Id}\r\n    err = o.Read(&u)\r\n    fmt.Println(u)\r\n    if err != nil {\r\n        fmt.Printf(\"ERR: %v\\n\", err)\r\n    }\r\n    // 删除表\r\n    num, err = o.Delete(&u)\r\n    fmt.Printf(\"NUM: %d, ERR: %v\\n\", num, err)\r\n}\r\n输出：\r\ntable `user` already exists, skip\r\nID: 6, ERR: <nil>\r\nNUM: 1, ERR: <nil>\r\n{6 astaxie}\r\nNUM: 1, ERR: <nil>\r\n成功: 进程退出代码 0.\r\n```\r\n','2018-08-10 11:01:30',4,1,4,0,NULL,'2018-08-10 11:01:30'),(32,' Go利用sync.WaitGroup实现协程同步','Go并发：利用sync.WaitGroup实现协程同步\r\n\r\n**WaitGroup**顾名思义，就是用来等待一组操作完成的。\r\nWaitGroup内部实现了一个计数器，用来记录未完成的操作个数，\r\n它提供了三个方法，\r\n###### Add()用来添加计数。\r\n###### Done()用来在操作结束时调用，使计数减一。\r\n###### Wait()用来等待所有的操作结束，即计数变为0，该函数会在计数不为0时等待，在计数为0时立即返回。\r\n\r\n例如：下面不用WaitGroup **程序不会执行**，因为这两个协程还没得到执行主协程已经结束了，而主协程结束时会结束所有其他协程。当然也有其他办法，但是使用WaitGroup最简单\r\n\r\n```\r\npackage main\r\n\r\nimport (\r\n    \"fmt\"\r\n    \"sync\"\r\n)\r\n\r\nfunc main() {\r\n\r\n    var wg sync.WaitGroup\r\n\r\n    wg.Add(2) // 因为有两个动作，所以增加2个计数\r\n    go func() {\r\n        fmt.Println(\"Goroutine 1\")\r\n        wg.Done() // 操作完成，减少一个计数\r\n    }()\r\n\r\n    go func() {\r\n        fmt.Println(\"Goroutine 2\")\r\n        wg.Done() // 操作完成，减少一个计数\r\n    }()\r\n\r\n    wg.Wait() // 等待，直到计数为0\r\n}\r\n```\r\n','2018-08-10 15:22:57',4,1,9,0,NULL,'2018-08-10 15:22:57'),(33,'使用空接口interface存储任意类型的数据','空interface(interface{})不包含任何的method，正因为如此，所有的类型都实现了空interface\r\n\r\n空interface可以存储任意类型的数值。它有点类似于C语言的void*类型。\r\n\r\n一个函数把interface{}作为参数，那么他可以接受任意类型的值作为参数，如果一个函数返回interface{},那么也就可以返回任意类型的值\r\n\r\n下面的例子是定义了一个空接类型的列表，实现了向列表中存储了整形数组.字符型.结构体类型 数据\r\n\r\n\r\n```\r\npackage main\r\n\r\nimport (\r\n    \"strconv\"\r\n     \"fmt\"\r\n)\r\n\r\ntype Element interface{}\r\ntype List []Element\r\n\r\ntype Person struct {\r\n    name string\r\n    age  int\r\n}\r\n\r\n//定义了String方法，实现了fmt.Stringer\r\nfunc (p Person) String() string {\r\n    return \"(name: \" + p.name + \" - age: \" + strconv.Itoa(p.age) + \" years)\"\r\n}\r\n\r\n func main() {\r\n    list := make(List, 3)\r\n    list[0] = 1       // an int\r\n    list[1] = \"Hello\" // a string\r\n    list[2] = Person{\"Dennis\", 70}\r\n    if value, ok := list[0].(int); ok {// 断言 ：为int 类型则打印\r\n        fmt.Printf(\"is an int and its value is %d\\n\", value)\r\n    }\r\n    for index, element := range list {\r\n        if value, ok := element.(int); ok {\r\n            fmt.Printf(\"list[%d] is an int and its value is %d\\n\", index, value)\r\n        } else if value, ok := element.(string); ok {\r\n            fmt.Printf(\"list[%d] is a string and its value is %s\\n\", index, value)\r\n        } else if value, ok := element.(Person); ok {\r\n            fmt.Printf(\"list[%d] is a Person and its value is %s\\n\", index, value)\r\n        } else {\r\n            fmt.Printf(\"list[%d] is of a different type\\n\", index)\r\n        }\r\n    }\r\n} \r\n控制台输出：\r\nis an int and its value is 1\r\nlist[0] is an int and its value is 1\r\nlist[1] is a string and its value is Hello\r\nlist[2] is a Person and its value is (name: Dennis - age: 70 years)\r\n```\r\n','2018-08-12 21:42:44',4,1,2,0,NULL,'2018-08-12 21:42:44');
/*!40000 ALTER TABLE `topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `token` varchar(255) NOT NULL DEFAULT '',
  `avatar` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `signature` varchar(1000) DEFAULT NULL,
  `in_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'朋也','123123','fcd1cb8e-b71f-46c3-9974-7225997b40c7','/static/upload/avatar/20180629153048.JPG','','','这家伙很懒，什么都没留下~','2016-08-26 09:22:16'),(4,'lvchay','19880710','edff4ced-78eb-4dcd-b4c8-b4e710f3a184','/static/imgs/avatar.png','','','','2018-08-04 07:14:12');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--


--
-- Dumping events for database 'blog-go'
--

--
-- Dumping routines for database 'blog-go'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-08-13 23:00:35
