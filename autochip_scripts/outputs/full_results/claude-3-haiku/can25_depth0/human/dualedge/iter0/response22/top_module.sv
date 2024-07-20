module top_module(
    input clk,
    input d,
    output reg q);

    // Dual-edge triggered flip-flop can be emulated using two regular flip-flops
    // One flip-flop triggered on positive clock edge, the other on negative clock edge
    // The outputs of the two flip-flops are then combined using a multiplexer

    reg q_pos, q_neg;

    always @(posedge clk) begin
        q_pos <= d;
    end

    always @(negedge clk) begin
        q_neg <= d;
    end

    // Use a multiplexer to select between the positive and negative edge triggered flip-flops
    always @(*) begin
        case (clk)
            1'b0: q = q_neg;
            1'b1: q = q_pos;
            default: q = q_pos; // Assign default value to avoid latch
        endcase
    end

endmodule
