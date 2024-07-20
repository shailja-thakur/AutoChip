module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);

    reg [7:0] Q;
    wire [2:0] select;
    
    assign select = {A, B, C};

    always @(posedge clk) begin
        if (enable) begin
            Q <= {Q[6:0], S};  // Shift right, MSB is shifted in first
        end
    end

    // 8-to-1 multiplexer logic for Z output
    always @(*) begin
        case (select)
            3'b000: Z = Q[0];
            3'b001: Z = Q[1];
            3'b002: Z = Q[2];
            3'b003: Z = Q[3];
            3'b004: Z = Q[4];
            3'b005: Z = Q[5];
            3'b006: Z = Q[6];
            3'b007: Z = Q[7];
            default: Z = 0;  // default case
        endcase
    end
    
endmodule
