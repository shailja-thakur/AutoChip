module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    reg [1:0] state;
    reg out_reg;
    reg next_state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b0;
            out_reg <= 1'b0;
        end else begin
            state <= next_state;
            out_reg <= (state == 2'b01);
        end
    end

    always @(state or j or k) begin
        case (state)
            2'b00: begin
                if (j) begin
                    next_state = 2'b01;
                end else begin
                    next_state = 2'b00;
                end
            end
            2'b01: begin
                if (k) begin
                    next_state = 2'b00;
                end else begin
                    next_state = 2'b01;
                end
            end
            default: begin
                next_state = 2'b00;
            end
        endcase
    end

    assign out = out_reg;

endmodule
