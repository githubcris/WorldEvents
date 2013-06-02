class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			 constraints {
                lang:'es'
            }
		}
		"/"(controller:"twitterLogin", action: "index")
		"/"(view:"/index")
		"500"(view:'/error')
	}
}
