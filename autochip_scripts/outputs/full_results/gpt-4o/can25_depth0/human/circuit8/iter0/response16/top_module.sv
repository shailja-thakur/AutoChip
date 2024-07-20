module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg [1:0] state; // Define the states

    always @(posedge clock) begin
        case (state)
            2'b00: begin
                // Initial states
                p <= 0;
                q <= 0;
                if (a == 1) 
                    state <= 2'b01;
                else
                    state <= 2'b00;
            end
            2'b01: begin
                p <= 1;
                q <= 0;
                if (a == 1)
                    state <= 2'b01;
                else 
                    state <= 2'b10;
            end
            2'b10: begin
                p <= 1;
                q <= 1;
                if (a == 1)
                    state <= 2'b01;
                else 
                    state <= 2'b10;
            end
        endcase
    end

    always @(negedge clock) begin
        if (a == 1)
            state <= 2'b01;
        else
            state <= 2'b00;
    end

endmodule
