module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=0, B=1, C=2, D=3;

    // Insert your code below

    // State transition logic: next_state = f(state, in)

    // Output logic:  out = f(state) for a Moore state machine

    always @(posedge clk) begin
        case (state)
            A:
                if (in == 0) begin
                    next_state <= A;
                    out <= 0;
                end else begin
                    next_state <= B;
                    out <= 0;
                end
            B:
                if (in == 0) begin
                    next_state <= C;
                    out <= 0;
                end else begin
                    next_state <= B;
                    out <= 0;
                end
            C:
                if (in == 0) begin
                    next_state <= A;
                    out <= 0;
                end else begin
                    next_state <= D;
                    out <= 0;
                end
            D:
                if (in == 0) begin
                    next_state <= C;
                    out <= 1;
                end else begin
                    next_state <= B;
                    out <= 1;
                end
        endcase
    end

endmodule