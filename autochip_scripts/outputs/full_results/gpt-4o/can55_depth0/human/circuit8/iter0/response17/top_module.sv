module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    // State variables
    reg state_p;
    reg state_q;

    // Sequential logic for updating p and q based on clock and input a
    always @(posedge clock) begin
        if (a == 1) begin
            state_p <= 1;
        end else begin
            state_p <= 0;
        end
        
        if (a == 1 && state_p == 0) begin
            state_q <= 1;
        end else begin
            state_q <= state_q;
        end
    end

    always @(negedge clock) begin
        if (state_p == 1) begin
            p <= 1;
        end else begin
            p <= 0;
        end

        if (state_q == 1) begin
            q <= 1;
        end else begin
            q <= 0;
        end
    end
endmodule
