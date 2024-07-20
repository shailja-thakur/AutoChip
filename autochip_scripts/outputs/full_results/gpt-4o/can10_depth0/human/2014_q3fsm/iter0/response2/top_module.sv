module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    reg [1:0] state, next_state;
    reg [1:0] count;

    localparam A = 2'b00, 
               B = 2'b01, 
               CHECK1 = 2'b10, 
               CHECK2 = 2'b11;

    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            count <= 2'b00;
            z <= 0;
        end
        else begin
            state <= next_state;
            if (state == CHECK1 || state == CHECK2) begin
                if (w) begin
                    count <= count + 1;
                end
            end
        end
    end

    always @(*) begin
        case (state)
            A: begin
                if (s) next_state = B;
                else next_state = A;
                z = 0;
            end
            B: begin
                next_state = CHECK1;
                z = 0;
            end
            CHECK1: begin
                next_state = CHECK2;
                z = 0;
            end
            CHECK2: begin
                if (count == 2) z = 1;
                else z = 0;
                next_state = B;
                count = 0;
            end
            default: begin
                next_state = A;
                z = 0;
            end
        endcase
    end
endmodule
