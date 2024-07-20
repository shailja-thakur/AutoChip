module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);
    
    reg [3:0] state;
    wire found_sequence;

    always @(posedge clk) begin
        if (reset) begin
            state <= 4'b0000;
            start_shifting <= 0;
        end else begin
            case(state)
                4'b0000: begin
                    if (data) begin
                        state <= 4'b0001;
                    end
                end
                4'b0001: begin
                    if (data) begin
                        state <= 4'b0011;
                    end else begin
                        state <= 4'b0000;
                    end
                end
                4'b0011: begin
                    if (data) begin
                        state <= 4'b0011;
                    end else begin
                        state <= 4'b0100;
                    end
                end
                4'b0100: begin
                    if (data) begin
                        state <= 4'b0001;
                    end else begin
                        state <= 4'b0101;
                    end
                end
                4'b0101: begin
                    if (data) begin
                        state <= 4'b0001;
                    end
                    start_shifting <= 1;
                end
            endcase
        end
    end

    assign found_sequence = (state == 4'b0101);

endmodule
