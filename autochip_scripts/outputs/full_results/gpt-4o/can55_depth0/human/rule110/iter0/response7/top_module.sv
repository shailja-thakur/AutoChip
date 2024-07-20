module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q;

    always @(*) begin
        // Use the Rule 110 table to compute the next state of each cell
        for (int i = 0; i < 512; i = i + 1) begin
            if (i == 0) begin
                next_q[i] = (q[i+1] == 1) && (q[i] == 1) && (0 == 1) ? 0 : (q[i+1] == 1) && (q[i] == 1) && (0 == 0) ? 1 : 
                            (q[i+1] == 0) && (q[i] == 1) && (0 == 1) ? 1 : (q[i+1] == 0) && (q[i] == 0) && (0 == 0) ? 0 :
                            (q[i+1] == 1) && (q[i] == 0) && (0 == 1) ? 1 :
                            (q[i+1] == 1) && (q[i] == 0) && (0 == 1);
            end
            else if (i == 511) begin
                next_q[i] = (0 == 1) && (q[i] == 1) && (q[i-1] == 1) ? 0 : (0 == 1) && (q[i] == 1) && (q[i-1] == 0) ? 1 : 
                            (0 == 0) && (q[i] == 1) && (q[i-1] == 1) ? 1 : (0 == 0) && (q[i] == 1) && (q[i-1] == 0) ? 0 :
                            (0 == 1) && (q[i] == 0) && (q[i-1] == 1) ? 1 :
                            (0 == 1) && (q[i] == 0) && (q[i-1] == 1);
            end 
            else begin
                next_q[i] =  (q[i + 1] == 1 && q[i] == 1 && q[i - 1] == 1) ? 0 :
                             (q[i + 1] == 0 && q[i] == 1 && q[i - 1] == 1) ? 1 :
                             (q[i + 1] == 1 && q[i] == 1 && q[i - 1] == 0) ? 1 :
                             (q[i + 1] == 0 && q[i] == 1 && q[i - 1] == 0) ? 1 :
                             (q[i + 1] == 1 && q[i] == 0 && q[i - 1] == 1) ? 1 : 
                             0;
                }
        end
    end

    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next_q;
    end

endmodule
