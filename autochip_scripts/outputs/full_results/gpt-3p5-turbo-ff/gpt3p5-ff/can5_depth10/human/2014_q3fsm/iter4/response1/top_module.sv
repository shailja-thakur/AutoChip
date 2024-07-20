module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    
    parameter A = 0;
    parameter B = 1;
    
    reg [1:0] state;
    reg [2:0] count;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            count <= 0;
            z <= 0;
        end else begin
            case (state)
                A: begin
                    if (s == 1)
                        state <= B;
                end
                B: begin
                    if (count == 0 || count == 1) begin // check for the first two clock cycles
                        if (w == 1)
                            count <= count + 1;
                    end else if (count == 2) begin // check for the third clock cycle
                        if (w == 1) begin
                            z <= 1;
                            count <= 0;
                        end else begin
                            z <= 0;
                            count <= 0;
                        end
                        state <= A;
                    end
                end
            endcase
        end
    end

endmodule
