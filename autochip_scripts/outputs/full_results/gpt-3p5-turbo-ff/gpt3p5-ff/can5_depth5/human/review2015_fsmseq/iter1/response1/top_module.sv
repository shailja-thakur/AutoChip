module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    wire is_sequence_detected;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            start_shifting <= 0;
        end else begin
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
                        state <= 3;
                        start_shifting <= 1;
                    end else begin
                        state <= 0;
                        start_shifting <= 0;
                    end
                end
            endcase
        end
    end
    
    assign is_sequence_detected = (state == 3);
    
endmodule
