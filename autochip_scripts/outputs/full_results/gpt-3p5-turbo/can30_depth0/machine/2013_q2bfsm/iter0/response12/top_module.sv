module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

    reg [3:0] present_state;
    reg [3:0] next_state;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            present_state <= 4'b0000; // Initialize to state S0
        end else begin
            present_state <= next_state;
        end
    end

    always @(present_state or x or y) begin
        case (present_state)
            4'b0000: begin // S0 state
                if (x) begin
                    next_state = 4'b1000; // transition to S1
                end else begin
                    next_state = 4'b0000; // stay in S0
                end
            end
            4'b1000: begin // S1 state
                if (x) begin
                    next_state = 4'b1000; // stay in S1
                end else begin
                    next_state = 4'b1010; // transition to S10
                end
            end
            4'b1010: begin // S10 state
                if (x) begin
                    next_state = 4'b1101; // transition to G1
                end else begin
                    next_state = 4'b0000; // transition to S0
                end
            end
            4'b1101: begin // G1 state
                if (y) begin
                    next_state = 4'b1111; // transition to P1
                end else begin
                    next_state = 4'b1110; // transition to G2
                end
            end
            4'b1110: begin // G2 state
                if (y) begin
                    next_state = 4'b1111; // transition to P1
                end else begin
                    next_state = 4'b1100; // transition to P0
                end
            end
            4'b1100: begin // P0 state
                next_state = 4'b1100; // stay in P0
            end
            4'b1111: begin // P1 state
                next_state = 4'b1111; // stay in P1
            end
            default: begin // Should not reach this state
                next_state = 4'b0000; // Go to initial state S0
            end
        endcase
    end

    assign f = (present_state == 4'b0010); // State B
    assign g = (present_state == 4'b1101) || (present_state == 4'b1110) || (present_state == 4'b1111); // States G1, G2, P1

endmodule
