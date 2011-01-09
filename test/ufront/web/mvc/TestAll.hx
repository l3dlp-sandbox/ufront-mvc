package ufront.web.mvc;
import ufront.web.routing.RouteCollection;
import ufront.web.mvc.view.TestHTemplateData;
                       
import ufront.web.mvc.MvcRouteHandler;
import ufront.web.routing.Route;
import ufront.web.routing.RouteData;
import ufront.web.HttpContextMock;
import thx.error.Error;
import ufront.web.routing.RequestContext;
import utest.Runner;
import utest.ui.Report;

class TestAll
{
	public static function addTests(runner : Runner)
	{                                                  
		TestControllerBindings.addTests(runner);
		TestDefaultControllerFactory.addTests(runner); 
		TestViewResult.addTests(runner); 
		TestHTemplateData.addTests(runner);
		TestValueProviders.addTests(runner);
		TestIActionFilter.addTests(runner);
		TestIAuthorizationFilter.addTests(runner);
		TestControllerFilters.addTests(runner);
		TestAuthorizeAttribute.addTests(runner);
		TestControllerFiltersMetaData.addTests(runner);
	}
	
	public static function main()
	{
		var runner = new Runner();
		addTests(runner);
		Report.create(runner);
		runner.run();
	}     

	public static function setupController(controller : Controller, ?action = "index") : ControllerContext
	{
		ControllerBuilder.current.attributes.remove("ufront.web.mvc.attributes");
		ControllerBuilder.current.attributes.add("ufront.web.mvc.attributes");
		
		controller.invoker = new ControllerActionInvoker(new ModelBinderDictionary(), ControllerBuilder.current);
		
		return new ControllerContext(controller, TestAll.getRequestContext(action));
	}
	
	public static function getRequestContext(?action = "index")
	{
		var data = new Hash<String>();
		data.set("action", action);
		
		var routeHandler = new MvcRouteHandler();
		var route = new Route("/", routeHandler);  
		var routes = new RouteCollection();
		routes.add(route);
		var context = new HttpContextMock();
		var routeData = new RouteData(route, routeHandler, data);
		return new RequestContext(context, routeData, routes);
	}
}