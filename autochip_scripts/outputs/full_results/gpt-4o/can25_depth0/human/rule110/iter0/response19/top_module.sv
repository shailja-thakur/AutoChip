module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    // Intermediate storage to calculate next state
    reg [511:0] next_q;
    
    // Function to evaluate next state based on Rule 110
    function automatic logic next_state(input logic l, c, r);
        // Apply Rule 110 logic
        case ({l, c, r})
            3'b111: next_state = 0;
            3'b110: next_state = 1;
            3'b101: next_state = 1;
            3'b100: next_state = 0;
            3'b011: next_state = 1;
            3'b010: next_state = 1;
            3'b001: next_state = 1;
            3'b000: next_state = 0;
            default: next_state = 0; // Should not be reached with case specified
        endcase
    endfunction

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Compute the next state for each cell
            next_q[0] = next_state(0, q[0], q[1]);
            next_q[511] = next_state(q[510], q[511], 0);
            for (int i = 1; i < 511; i = i + 1) begin
                next_q[i] = next_state(q[i-1], q[i], q[i+1]);
            end
            q <= next_q;
        end
    end
    
endmodule
