module top_module (input clk, input in, input reset, output reg out);
    parameter A = 0;
    parameter B = 1;
    
    reg [1:0] state;
    
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            state <= B;
        end else begin
            case(state)
                A: begin
                    if (in == 1'b1) begin
                        state <= A;
                    end else begin
                        state <= B;
                    end
                end
                B: begin
                    if (in == 1'b1) begin
                        state <= B;
                    end else begin
                        state <= A;
                    end
                end
            endcase
        end
    end
    
    assign out = (state == B) ? 1'b1 : 1'b0;
endmodule
