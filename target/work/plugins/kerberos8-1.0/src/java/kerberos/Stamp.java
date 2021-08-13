package kerberos;

import org.codehaus.groovy.transform.GroovyASTTransformationClass;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import java.util.Date;

@Retention(RetentionPolicy.SOURCE)
@Target({ElementType.TYPE})
@GroovyASTTransformationClass({"kerberos.StampASTTransformation"})
public @interface Stamp {
	
	StampInfo dateCreated() default @StampInfo(type=Date.class);
	StampInfo lastUpdated() default @StampInfo(type=Date.class);
	
	StampInfo createdBy() default @StampInfo(type=String.class, nullable=true);
	StampInfo lastUpdatedBy() default @StampInfo(type=String.class,nullable=true);
	
}
