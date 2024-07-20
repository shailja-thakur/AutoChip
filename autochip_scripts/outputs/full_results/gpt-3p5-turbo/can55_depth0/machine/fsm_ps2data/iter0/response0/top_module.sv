module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);
    reg [23:0] out_reg;
    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            out_reg <= 24'b0;
            done <= 1'b0;
        end else begin
            case (state)
                3'b000: begin
                    if (in[2] == 1'b1)
                        state <= 3'b001;
                    else
                        state <= 3'b000;
                end
                3'b001: state <= 3'b010;
                3'b010: state <= 3'b011;
                3'b011: state <= 3'b100;
                3'b100: state <= 3'b000;
                default: state <= 3'b000;
            endcase
            if (state == 3'b100)
                done <= 1'b1;
            else
                done <= 1'b0;
            out_reg <= {out_reg[15:0], in};
        end
    end
    
    assign out_bytes = out_reg;
    
endmodule
