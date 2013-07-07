class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			 
		}
		"/"(controller:"twitterLogin", action: "index")
			"500"(view:'/error')
			
	}
}
