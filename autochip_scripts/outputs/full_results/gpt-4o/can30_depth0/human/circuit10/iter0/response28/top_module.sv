module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

    reg state, next_state;

    always @ (posedge clk) begin
        state <= next_state;
    end

    always @ (*) begin
        if (a == 1 && b == 1) begin
            next_state = ~state;
        end else if (a == 1) begin
            next_state = state;
        end else if (b == 1) begin
            next_state = ~state;
        end else begin
            next_state = state;
        end
    end

    assign q = state;

endmodule
