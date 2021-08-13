package kerberos;

public @interface StampInfo{
	boolean nullable() default true;
	boolean exclude() default false;
	Class<?> type() default String.class;
}
