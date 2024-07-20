module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

    // Combinational logic to determine the next state of each cell
    function [511:0] next_state;
        input [511:0] current_state;
        reg [511:0] next_state;
        integer i;
        begin
            next_state[0] = current_state[1]; // Boundary condition: q[-1] = 0
            for (i = 1; i < 511; i = i + 1) begin
                case ({current_state[i-1], current_state[i], current_state[i+1]})
                    3'b111: next_state[i] = 0;
                    3'b110: next_state[i] = 1;
                    3'b101: next_state[i] = 1;
                    3'b100: next_state[i] = 0;
                    3'b011: next_state[i] = 1;
                    3'b010: next_state[i] = 1;
                    3'b001: next_state[i] = 1;
                    3'b000: next_state[i] = 0;
                endcase
            end
            next_state[511] = 0; // Boundary condition: q[512] = 0
            next_state_func = next_state;
        end
    endfunction

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_state(q);
        end
    end

endmodule
