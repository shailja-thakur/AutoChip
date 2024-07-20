module top_module (
    input  clk,
    input  resetn,
    input  x,
    input  y,
    output f,
    output g
);

    // State definition
    typedef enum logic [3:0] {
        A,
        B,
        S0,
        S1,
        S10,
        G1,
        G2,
        P0,
        P1
    } state_t;
    
    // Registers
    reg [2:0] curr_state;
    reg [2:0] next_state;

    // Outputs
    assign f = (curr_state == B);
    assign g = (curr_state == G1 || curr_state == G2 || curr_state == P1);

    // State transition logic
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            curr_state <= A;
        end else begin
            curr_state <= next_state;
        end
    end
    
    // Next state logic
    always_comb begin
        case (curr_state)
            A: begin
                if (x) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                next_state = S0;
            end
            S0: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S0;
                end
            end
            S1: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S10;
                end
            end
            S10: begin
                if (x) begin
                    next_state = G1;
                end else begin
                    next_state = S0;
                end
            end
            G1: begin
                if (y) begin
                    next_state = P1;
                end else begin
                    next_state = G2;
                end
            end
            G2: begin
                if (y) begin
                    next_state = P1;
                end else begin
                    next_state = P0;
                end
            end
            P0, P1: begin
                next_state = curr_state;
            end
        endcase
    end

endmodule
