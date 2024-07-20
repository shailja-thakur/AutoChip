module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [1:0] state;
    assign start_shifting = (state == 2'b11);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
        end else begin
            case (state)
                2'b00: begin
                    if (data) begin
                        state <= 2'b01;
                    else
                        state <= 2'b00;
                    end
                end
                2'b01: begin
                    if (data) begin
                        state <= 2'b11;
                    else
                        state <= 2'b00;
                    end
                end
                2'b11: begin
                    if (data) begin
                        state <= 2'b11;
                    else
                        state <= 2'b10;
                    end
                end
                2'b10: begin
                    if (data) begin
                        state <= 2'b11;
                    else
                        state <= 2'b00;
                    end
                end
            endcase
        end
    end
endmodule
