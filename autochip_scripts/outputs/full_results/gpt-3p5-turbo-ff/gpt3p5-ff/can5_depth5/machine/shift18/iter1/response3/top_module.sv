module top_module(
    input wire clk,
    input wire load,
    input wire ena,
    input wire [1:0] amount,
    input wire [63:0] data,
    output wire reg [63:0] q);

    reg [63:0] q_next;

    always @(posedge clk) begin
        if (load) begin
            q_next <= {q[62:0], 1'b0};
        end
        else if (ena) begin
            case(amount)
                2'b00: q_next <= {q[55:0], 8'b0};
                2'b01: q_next <= {q[63], q[55:0]};
                2'b10: q_next <= {q[63], q[63:1]};
                2'b11: q_next <= {{8{q[63]}}, q[63:8]};
                default: q_next <= 64'hx;
            endcase
        end
        else begin
            q_next <= q;
        end
    end

    always @(posedge clk) begin
        q <= q_next;
    end
    
endmodule
