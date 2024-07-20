module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    // Internal wires and registers
    reg [511:0] q_tmp;
    reg [511:0] q_next;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= q_next;
        end
    end

    always @(q) begin
        q_tmp = {0, q, 0}; // considering the boundaries
        q_next = 512'b0;
        
        // Rule 90 logic
        for (int i = 0; i < 512; i = i + 1) begin
            case ({q_tmp[i+1], q_tmp[i], q_tmp[i-1]}) 
                3'b111 : q_next[i] = 1'b0;
                3'b110 : q_next[i] = 1'b1;
                3'b101 : q_next[i] = 1'b0;
                3'b100 : q_next[i] = 1'b1;
                3'b011 : q_next[i] = 1'b1;
                3'b010 : q_next[i] = 1'b0;
                3'b001 : q_next[i] = 1'b1;
                3'b000 : q_next[i] = 1'b0;
            endcase
        end
    end

endmodule
