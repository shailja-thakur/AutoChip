module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    // internal variables
    reg [3:0] units;
    reg [3:0] tens;
    reg [3:0] hundreds;
    reg [3:0] thousands;
    
    // always block for counter logic
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            q <= 0;
            units <= 0;
            tens <= 0;
            hundreds <= 0;
            thousands <= 0;
        end else begin
            if(ena[0])
                units <= units + 1;
                
            if(ena[1])
                tens <= tens + 1;
                
            if(ena[2])
                hundreds <= hundreds + 1;
                
            // increment thousands every 10,000 cycles
            if((units == 9) && (tens == 9) && (hundreds == 9))
                thousands <= thousands + 1;
            
            q[3:0] = units;
            q[7:4] = tens;
            q[11:8] = hundreds;
            q[15:12] = thousands;
        end
    end
endmodule
