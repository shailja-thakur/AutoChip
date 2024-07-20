module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg start_flag;
    
    always @(posedge clk or poself(state)) begin
        if (reset) begin
            state <= 0;
            start_shifting <= 0;
        end else begin
            if (start_flag) begin
                start_shifting <= 1;
            end else begin
                start_shifting <= 0;
            end
            
            case(state)
                0: begin
                    if (data) begin
                        state <= 1;
                    end else begin
                        state <= 0;
                    end
                end
                1: begin
                    if (data) begin
                        state <= 2;
                    end else begin
                        state <= 0;
                    end
                end
                2: begin
                    if (data) begin
                        state <= 3;
                    end else begin
                        state <= 0;
                    end
                end
                3: begin
                    if (data) begin
                        start_flag <= 1;
                        state <= 3;
                    end else begin
                        start_flag <= 0;
                        state <= 0;
                    end
                end
            endcase
        end
    end
endmodule
