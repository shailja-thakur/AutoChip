module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg [1:0] state;
    always @(posedge clk or negedge areset) begin
        if (areset) begin
            state <= 2'b10; // B
        end else begin
            case(state)
                2'b00: begin
                    if (in) begin
                        state <= 2'b01; // A
                    end else begin
                        state <= 2'b00; // B
                    end
                end
                2'b01: begin
                    if (in) begin
                        state <= 2'b01; // A
                    end else begin
                        state <= 2'b00; // B
                    end
                end
                2'b10: begin
                    if (in) begin
                        state <= 2'b11; // A
                    end else begin
                        state <= 2'b10; // B
                    end
                end
                2'b11: begin
                    if (in) begin
                        state <= 2'b11; // A
                    end else begin
                        state <= 2'b10; // B
                    end
                end
            endcase
        end
    end

    assign out = (state == 2'b00);

endmodule
