module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);
    
    reg [1:0] state;
    reg [23:0] shift_reg;
    reg [7:0] byte_cnt;
    reg [23:0] out_buffer;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b00;
            shift_reg <= 24'b0;
            byte_cnt <= 8'b0;
            out_buffer <= 24'b0;
            done <= 0;
        end else begin
            case(state)
                2'b00: begin
                    if (in[3] == 1'b1) begin
                        state <= 2'b01;
                        shift_reg <= {shift_reg[15:0], in};
                        byte_cnt <= 8'b1;
                    end else begin
                        shift_reg <= {shift_reg[15:0], in};
                    end
                end
                2'b01: begin
                    if (byte_cnt == 8'b2) begin
                        state <= 2'b10;
                        shift_reg <= {shift_reg[7:0], in};
                        byte_cnt <= byte_cnt + 1;
                    end else begin
                        shift_reg <= {shift_reg[15:0], in};
                        byte_cnt <= byte_cnt + 1;
                    end
                end
                2'b10: begin
                    state <= 2'b00;
                    shift_reg <= {shift_reg[15:0], in};
                    byte_cnt <= 8'b0;
                    out_buffer <= shift_reg;
                    done <= 1;
                end
            endcase
        end
    end
    
    assign out_bytes = out_buffer;
    
endmodule
