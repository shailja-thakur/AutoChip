module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
    // State definition
    reg [1:0] state;
    
    // Registers for byte storage
    reg [7:0] byte1;
    reg [7:0] byte2;
    reg [7:0] byte3;
    
    // Output registers
    reg [23:0] out_bytes_r;
    reg done_r;
    
    // Combinational logic
    always @(*) begin
        case (state)
            2'b00: begin
                byte1 = 0;
                byte2 = 0;
                byte3 = 0;
                out_bytes_r = 0;
                done_r = 0;
            end
            2'b01: begin
                byte1 = in;
                byte2 = 0;
                byte3 = 0;
                out_bytes_r = 0;
                done_r = 0;
            end
            2'b10: begin
                byte2 = in;
                byte3 = 0;
                out_bytes_r = 0;
                done_r = 0;
            end
            2'b11: begin
                byte3 = in;
                out_bytes_r = {byte1, byte2, byte3};
                done_r = 1;
            end
            default: begin
                byte1 = 0;
                byte2 = 0;
                byte3 = 0;
                out_bytes_r = 0;
                done_r = 0;
            end
        endcase
    end
    
    // State machine
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
        end else begin
            case (state)
                2'b00: begin
                    if (in[3]) begin
                        state <= 2'b01;
                    end
                end
                2'b01: begin
                    state <= 2'b10;
                end
                2'b10: begin
                    state <= 2'b11;
                end
                2'b11: begin
                    state <= 2'b00;
                end
                default: begin
                    state <= 2'b00;
                end
            endcase
        end
    end
    
    // Output assignment
    assign out_bytes = out_bytes_r;
    assign done = done_r;
    
endmodule
