module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);
    
    reg [2:0] state;
    reg [23:0] shift_reg;
    
    // State definitions
    parameter BYTE1 = 3'b000;
    parameter BYTE2 = 3'b001;
    parameter BYTE3 = 3'b010;
    parameter DONE = 3'b011;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            shift_reg <= 24'b0;
        end else begin
            case (state)
                BYTE1:
                    if (in[2] == 1) begin
                        state <= BYTE2;
                    else
                        state <= BYTE1;
                
                BYTE2:
                    if (in[2] == 1) begin
                        state <= BYTE3;
                    end
                
                BYTE3:
                    state <= DONE;
                
                DONE:
                    if (in[2] == 0) begin
                        state <= BYTE1;
                    end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (state == DONE) begin
            out_bytes <= shift_reg;
            done <= 1;
        end else begin
            shift_reg <= {shift_reg[15:0], in};
            done <= 0;
        end
    end
    
endmodule
