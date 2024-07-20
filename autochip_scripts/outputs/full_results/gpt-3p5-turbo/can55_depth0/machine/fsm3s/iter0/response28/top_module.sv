module top_module (
	input clk,
	input in,
	input reset,
	output out
);

    reg [1:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 2'b00; // A
        else
            case (state)
                2'b00: // A
                    if (in)
                        state <= 2'b01; // B
                    else
                        state <= 2'b00; // A
                2'b01: // B
                    if (in)
                        state <= 2'b01; // B
                    else
                        state <= 2'b10; // C
                2'b10: // C
                    if (in)
                        state <= 2'b11; // D
                    else
                        state <= 2'b00; // A
                2'b11: // D
                    if (in)
                        state <= 2'b01; // B
                    else
                        state <= 2'b10; // C
            endcase
    end
    
    assign out = (state == 2'b11); // D
    
endmodule
