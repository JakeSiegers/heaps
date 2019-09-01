package hxd;

import haxe.io.Bytes;

/**
 * Tries to provide consistent access to haxe.io.bytes from any primitive
 */
class ByteConversions{

#if (flash || (openfl && !heaps_noOpenFl))

	public static function byteArrayToBytes( v: flash.utils.ByteArray ) : haxe.io.Bytes {
		return
		#if flash
		Bytes.ofData( v );
		#elseif (js&&openfl)
		{
			var b :Bytes = Bytes.alloc(v.length);
			for ( i in 0...v.length )
				b.set(i,v[i]);
			b;
		};
		#elseif (openfl && !heaps_noOpenFl)
		v;
		#else
		throw "unsupported on this platform";
		#end
	}

	public static function bytesToByteArray( v: haxe.io.Bytes ) :  flash.utils.ByteArray {
		#if flash
		return v.getData();
		#elseif (openfl && !heaps_noOpenFl)
		return flash.utils.ByteArray.fromBytes(v);
		#else
		throw "unsupported on this platform";
		#end
	}

	#if js
	public static function arrayBufferToBytes( v : js.html.ArrayBuffer ) : haxe.io.Bytes{
		return byteArrayToBytes(flash.utils.ByteArray.nmeOfBuffer(v));
	}
	#end

#end

}
