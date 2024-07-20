module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    reg [3:0] state;
    wire [3:0] sequence = 4'b1101;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000;
        end else begin
            case (state)
                4'b0000: begin
                    if (data == sequence[0]) begin
                        state <= 4'b0001;
                    end else begin
                        state <= 4'b0000;
                    end
                end
                4'b0001: begin
                    if (data == sequence[1]) begin
                        state <= 4'b0010;
                    end else begin
                        state <= 4'b0000;
                    end
                end
                4'b0010: begin
                    if (data == sequence[2]) begin
                        state <= 4'b0011;
                    end else begin
                        state <= 4'b0000;
                    end
                end
                4'b0011: begin
                    if (data == sequence[3]) begin
                        state <= 4'b0011;
                        start_shifting <= 1;
                    end else begin
                        state <= 4'b0000;
                    end
                end
            endcase
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            start_shifting <= 0;
        end
    end

endmodule
