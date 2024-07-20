module top_module(
    input wire clk,
    input wire load,
    input wire ena,
    input wire [1:0] amount,
    input wire [63:0] data,
    output reg [63:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= {q[62:0], 1'b0};
        end else if (ena) begin
            case (amount)
                2'b00: q <= {q[62:0], 1'b0};
                2'b01: q <= {q[55:0], 8'b0};
                2'b10: q <= {q[63], q[63:1]};
                2'b11: q <= {{8{q[63]}}, q[63:8]};
                default: q <= q; // No change to q
            endcase
        end else begin
            q <= q; // No change to q
        end
    end

    initial begin
        #5;
        load = 1;
        #10;
        load = 0;
        #5;
        ena = 1;
        amount = 2'b01;
        #10;
        amount = 2'b10;
        #10;
        amount = 2'b11;
        #10;
        amount = 2'b00;
        #100;
        $finish;
    end

    always @(posedge clk) begin
        clk <= ~clk;
    end
endmodule
