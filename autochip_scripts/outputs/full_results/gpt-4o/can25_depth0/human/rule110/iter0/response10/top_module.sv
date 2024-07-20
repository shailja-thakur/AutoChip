module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_state;

    always @(*) begin
        next_state[0] = (q[1] == 1'b1) ? 1'b1 : 1'b0; // Boundaries assume q[-1] = 0
        next_state[511] = (q[510] == 1'b1) ? 1'b1: 1'b0; // Boundaries assume q[512] = 0
      
        // Calculate the next state of each cell
        for (integer i = 1; i < 511; i = i + 1) begin
            if (q[i-1] == 1'b1 && q[i] == 1'b1 && q[i+1] == 1'b1)
                next_state[i] = 1'b0;
            else if (q[i-1] == 1'b1 && q[i] == 1'b1 && q[i+1] == 1'b0)
                next_state[i] = 1'b1;
            else if (q[i-1] == 1'b1 && q[i] == 1'b0 && q[i+1] == 1'b1)
                next_state[i] = 1'b1;
            else if (q[i-1] == 1'b1 && q[i] == 1'b0 && q[i+1] == 1'b0)
                next_state[i] = 1'b0;
            else if (q[i-1] == 1'b0 && q[i] == 1'b1 && q[i+1] == 1'b1)
                next_state[i] = 1'b1;
            else if (q[i-1] == 1'b0 && q[i] == 1'b1 && q[i+1] == 1'b0)
                next_state[i] = 1'b1;
            else if (q[i-1] == 1'b0 && q[i] == 1'b0 && q[i+1] == 1'b1)
                next_state[i] = 1'b1;
            else 
                next_state[i] = 1'b0;
        end
    end

    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_state;
    end
   
endmodule
