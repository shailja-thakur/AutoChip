module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [2:0] state;
reg [23:0] temp_register;
reg done;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000;
    else begin
        case (state)
            3'b000: begin
                if (in[2] == 1)
                    state <= 3'b001;
                else
                    state <= 3'b000;
            end
            3'b001: begin
                if (in[2] == 1)
                    state <= 3'b010;
                else
                    state <= 3'b000;
            end
            3'b010: begin
                if (in[2] == 1)
                    state <= 3'b011;
                else
                    state <= 3'b000;
            end
            3'b011: begin
                state <= 3'b100;
            end
            default: begin
                state <= 3'b000;
            end
        endcase
    end
end

always @(posedge clk) begin
    if (state == 3'b100)
        done <= 1'b1;
    else
        done <= 1'b0;
        
    if (done)
        out_bytes <= temp_register;
    
    temp_register <= {temp_register[15:0], in};
end

endmodule
