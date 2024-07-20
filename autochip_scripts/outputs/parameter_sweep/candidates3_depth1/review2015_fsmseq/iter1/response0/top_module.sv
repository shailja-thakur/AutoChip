module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000;
            start_shifting <= 0;
        end else begin
            case (state)
                4'b0000: begin
                    if (data) begin
                        state <= 4'b0001;
                    end else begin
                        state <= 4'b0000;
                    end
                end
                4'b0001: begin
                    if (data) begin
                        state <= 4'b0010;
                    end else begin
                        state <= 4'b0000;
                    end
                end
                4'b0010: begin
                    if (data) begin
                        state <= 4'b0011;
                    end else begin
                        state <= 4'b0000;
                    end
                end
                4'b0011: begin
                    state <= 4'b0011;
                    start_shifting <= data; // Set start_shifting to data value
                    if (!data) begin // Go back to state 0 if data is not 1
                        state <= 4'b0000;
                    end
                end
                default: begin
                    state <= 4'b0000;
                    start_shifting <= 0;
                end
            endcase
        end
    end
    
endmodule
