module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    reg [3:0] state;
    wire seq_match;
    
    // Detecting the sequence 1101
    assign seq_match = (state == 4'b1101);
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            start_shifting <= 0;
        end
        else begin
            case (state)
                0: begin
                    if (data) begin
                        state <= 1;
                    end
                end
                1: begin
                    if (data) begin
                        state <= 2;
                    end
                    else begin
                        state <= 0;
                    end
                end
                2: begin
                    if (data) begin
                        state <= 3;
                    end
                    else begin
                        state <= 0;
                    end
                end
                3: begin
                    if (data) begin
                        state <= 4;
                    end
                    else begin
                        state <= 0;
                    end
                end
                4: begin
                    if (data) begin
                        state <= 4;
                        start_shifting <= 1; // Set start_shifting to 1 when sequence is found
                    end
                    else begin
                        state <= 0;
                    end
                end
            endcase
        end
    end

endmodule
