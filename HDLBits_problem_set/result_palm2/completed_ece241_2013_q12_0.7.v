module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 

    reg [7:0] Q;
    reg [1:0] sel;

    always @(posedge clk) begin
        if (enable) begin
            Q <= Q << 1;
            if (S) begin
                Q[0] <= A;
                Q[1] <= B;
                Q[2] <= C;
            end
        end
    end

    mux4way #(8) M (
        [7:0] Q,
        [1:0] sel,
        output Z
    );

endmodule