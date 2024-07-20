module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    reg [1:0] state;
    wire x_out;

    // State A
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00;
        end else begin
            case (state)
                2'b00: begin
                    if (x) begin
                        state <= 2'b01;
                    end else begin
                        state <= 2'b00;
                    end
                end
                2'b01: begin
                    if (x) begin
                        state <= 2'b01;
                    end else begin
                        state <= 2'b10;
                    end
                end
                default: begin
                    state <= 2'b10;
                end
            endcase
        end
    end

    // State B
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b00;
        end else begin
            case (state)
                2'b00: begin
                    if (x) begin
                        state <= 2'b01;
                    end else begin
                        state <= 2'b00;
                    end
                end
                default: begin
                    state <= 2'b01;
                end
            endcase
        end
    end

    // Output logic
    assign x_out = (x && (state == 2'b01));
    assign z = ~x_out;

endmodule
