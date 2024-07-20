module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    reg [1:0] current_state, next_state;
    parameter A = 2'b00;
    parameter B = 2'b01;

    always @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    always @* begin
        case (current_state)
            A: begin
                if (x)
                    next_state = B;
                else
                    next_state = A;
                z = 1'b0;
            end
            B: begin
                if (!x)
                    next_state = A;
                else
                    next_state = B;
                z = 1'b1;
            end
        endcase
    end
endmodule
module top_tb();
    reg clk, areset, x;
    wire z;

    top_module dut (
        .clk(clk),
        .areset(areset),
        .x(x),
        .z(z)
    );

    always begin
        #5 clk = ~clk;
    end

    initial begin
        clk = 0;
        areset = 1;
        x = 0;
        #10 areset = 0;
        #10 x = 1;
        #10 x = 0;
        #10 x = 1;
        #10 x = 0;
        #10 x = 1;
        #10 x = 0;
        #10 x = 1;
        #10 $finish;
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, top_module);
        $monitor($time, " z = %b", z);
    end

endmodule
