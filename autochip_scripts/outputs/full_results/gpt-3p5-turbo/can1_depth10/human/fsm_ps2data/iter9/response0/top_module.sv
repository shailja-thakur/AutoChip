module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output reg done
);

    reg [1:0] state;
    reg [23:0] shift_reg;
    reg [23:0] out_buffer;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b00;
            shift_reg <= 24'b0;
            out_buffer <= 24'b0;
            done <= 0;
        end else begin
            case(state)
                2'b00: begin
                    if (in[3] == 1'b1) begin
                        state <= 2'b01;
                        shift_reg <= {in, shift_reg[23:8]};
                    end else begin
                        shift_reg <= {in, shift_reg[23:8]};
                    end
                end
                2'b01: begin
                    shift_reg <= {in, shift_reg[23:8]};
                    if (shift_reg[7:0] != 8'b0) begin
                        state <= 2'b10;
                        out_buffer <= shift_reg;
                        done <= 1;
                    end
                end
                2'b10: begin
                    state <= 2'b00;
                    shift_reg <= {in, shift_reg[23:8]};
                    done <= 0;
                end
            endcase
        end
    end
    
    assign out_bytes = out_buffer;
    
endmodule
