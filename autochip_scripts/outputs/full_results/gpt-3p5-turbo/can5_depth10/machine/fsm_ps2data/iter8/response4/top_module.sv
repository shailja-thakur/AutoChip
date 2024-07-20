module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    reg [2:0] state;
    reg [2:0] next_state;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            state <= next_state;
            case (state)
                3'b000: begin
                    if (in[2] == 1)
                        next_state = 3'b001;
                    else
                        next_state = 3'b000;
                end
                3'b001: begin
                    if (in[2] == 0)
                        next_state = 3'b000;
                    else
                        next_state = 3'b010;
                end
                3'b010: begin
                    if (in[2] == 0)
                        next_state = 3'b000;
                    else
                        next_state = 3'b011;
                end
                3'b011: begin
                    if (in[2] == 0)
                        next_state = 3'b000;
                    else
                        next_state = 3'b100;
                end
                3'b100: next_state = 3'b000;
                default: next_state = 3'b000;
            endcase
            
            if (state == 3'b011)
                done <= 1;
            else
                done <= 0;
                
            if (done)
                out_bytes <= {in, out_bytes[23:8]};
            else
                out_bytes <= out_bytes;
        end
    end
endmodule
