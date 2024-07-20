module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [1:0] state;
reg z;
reg zbar;
reg areset_prev;

always @(posedge clk or posedge areset)
    if (areset)
        state <= 2'b00;
    else
        state <= next_state;

always @(posedge clk or posedge areset)
    areset_prev <= areset;

always @(state or x or z or zbar)
    case (state)
        2'b00: begin
            if (areset_prev == 1'b1)
                z <= 1'b0;
            else
                z <= zbar;
            
            if (x)
                next_state <= 2'b01;
            else
                next_state <= 2'b00;
        end
        
        2'b01: begin
            if (areset_prev == 1'b1)
                zbar <= 1'b1;
            else
                zbar <= ~zbar;
                
            if (x)
                next_state <= 2'b10;
            else
                next_state <= 2'b01;
        end
        
        2'b10: begin
            if (areset_prev == 1'b1)
                zbar <= 1'b0;
            else
                zbar <= zbar;
                
            if (x)
                next_state <= 2'b01;
            else
                next_state <= 2'b00;
        end
        
        default: 
            next_state <= 2'b00;
        
    endcase

endmodule
