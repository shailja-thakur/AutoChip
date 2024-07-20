module top_module(
    input clk,
    input d,
    output reg q);

    // Use two flip-flops, one triggering on posedge and the other on negedge
    reg q_pos, q_neg;

    always @(posedge clk) begin
        q_pos <= d;
    end

    always @(negedge clk) begin
        q_neg <= d;
    end

    // Use a mux to combine the outputs of the two flip-flops
    always @(*) begin
        case (clk)
            1'b0: q = q_neg;
            1'b1: q = q_pos;
            default: q = q_pos; // Assign a default value in case of unknown clock state
        endcase
    end

endmodule
