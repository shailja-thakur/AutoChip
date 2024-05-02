module top_module( 
    input [15:0] a, b, c, d, e, f, g, h, i,
    input [3:0] sel,
    output [15:0] out );

    //Case statement to select the input based on the sel value
    case sel is
        when 0 => out <= a;
        when 1 => out <= b;
        when 2 => out <= c;
        when 3 => out <= d;
        when 4 => out <= e;
        when 5 => out <= f;
        when 6 => out <= g;
        when 7 => out <= h;
        when 8 => out <= i;
        when others => out <= 16'hffff;
    end case;

endmodule