module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q;
    
    // Function to determine next state for a given cell
    function next_state;
        input left, center, right;
        begin
            case ({left, center, right})
                3'b111: next_state = 0;
                3'b110: next_state = 1;
                3'b101: next_state = 1;
                3'b100: next_state = 0;
                3'b011: next_state = 1;
                3'b010: next_state = 1;
                3'b001: next_state = 1;
                3'b000: next_state = 0;
                default: next_state = 0;
            endcase
        end
    endfunction

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Calculate the next state of each cell
            integer i;
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0)
                    next_q[i] = next_state(0, q[i], q[i+1]);  // q[-1] is 0
                else if (i == 511)
                    next_q[i] = next_state(q[i-1], q[i], 0); // q[512] is 0
                else
                    next_q[i] = next_state(q[i-1], q[i], q[i+1]);
            end
            q <= next_q;
        end
    end

endmodule
