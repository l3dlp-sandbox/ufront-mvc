package ufront.core;

import tink.core.Error.Pos;
import ufront.web.HttpError;
using tink.CoreApi;

/**
	Simple shortcuts for creating Future's synchronously
**/
class Sync {

	/**
		Return a Success(Noise) to satisfy Surprise<Noise,T>
	**/
	public static inline function success():Surprise<Noise,HttpError> {
		if ( s==null ) s = Future.sync( Success(Noise) );
		return s;
	}
	static var s:Surprise<Noise,HttpError>;

	/**
		Return a Failure(HttpError) to satisfy Surprise<T,HttpError>

		Will wrap your error with `HttpError.internalServerError(err)`
	**/
	public static inline function httpError( ?msg:String, ?err:Dynamic, ?p:Pos ):Surprise<Noise,HttpError> {
		return Future.sync( Failure( HttpError.internalServerError(msg,err,p) ) );
	}

	/**
		Alias for `tink.core.Future.sync(v)`
	**/
	public static function of<T>( v:T ) {
		return Future.sync( v );
	}
}