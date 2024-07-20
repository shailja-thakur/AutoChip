module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

    reg [1:0] state; // Define a state register to hold the state of the FSM

    // State encoding
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;
    localparam S3 = 2'b11;

    // State transition and output logic
    always @(posedge clock or negedge clock) begin
        if (~clock) begin
            case(state)
                S0: begin
                    if (a)
                        state <= S1;
                    else
                        state <= S0;
                end
                S1: begin
                    if (a)
                        state <= S2;
                    else
                        state <= S0;
                end
                S2: begin
                    if (a)
                        state <= S3;
                    else
                        state <= S0;
                end
                S3: begin
                    if (~a)
                        state <= S0;
                    else
                        state <= S3;
                end
            endcase
        end
    end

    // Output logic
    always @(posedge clock or negedge clock) begin
        if (~clock) begin
            p <= (state == S1) || (state == S2) || (state == S3);
            q <= (state == S2) || (state == S3);
        end
    end

endmodule
