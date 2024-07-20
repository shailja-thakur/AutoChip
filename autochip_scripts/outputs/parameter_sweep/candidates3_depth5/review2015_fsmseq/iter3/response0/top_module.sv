module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    wire start_sequence;

    assign start_sequence = (state == 4'b1101);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000;
            start_shifting <= 0;
        end else begin
            case (state)
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
                        state <= 4'b0111;
                    end else begin
                        state <= 4'b0000;
                    end
                end
                4'b0111: begin
                    if (data) begin
                        state <= 4'b1111;
                    end else begin
                        state <= 4'b0000;
                    end
                end
                4'b1111: begin
                    if (data) begin
                        state <= 4'b1111;
                    end else begin
                        state <= 4'b0000;
                        start_shifting <= start_sequence;
                    end
                end
            endcase
        end
    end

endmodule
