module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);
    reg [1:0] state;
    reg [1:0] next_state;

    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

    always @(posedge clock) begin
        state <= next_state;
    end

    always @(*) begin
        case (state)
            S0: begin
                p = 0;
                q = 0;
                if (a) next_state = S1;
                else next_state = S0;
            end
            S1: begin
                p = 1;
                q = 0;
                if (a) next_state = S1;
                else next_state = S2;
            end
            S2: begin
                p = 1;
                q = 1;
                if (a) next_state = S1;
                else next_state = S3;
            end
            S3: begin
                p = 0;
                q = 1;
                if (a) next_state = S1;
                else next_state = S0;
            end
            default: begin
                p = 0;
                q = 0;
                next_state = S0;
            end
        endcase
    end
endmodule
