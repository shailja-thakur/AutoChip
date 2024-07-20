module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);
    reg [1:0] counter;

    always @(posedge clk or posedge areset) begin
        if(areset) begin
            counter <= 2'b01; // Reset to weakly not-taken (2'b01)
        end else begin
            if(train_valid) begin
                if(train_taken) begin
                    if(counter < 2'b11) begin
                        counter <= counter + 1; // Increment when train_valid = 1 and train_taken = 1 (up to maximum of 3)
                    end
                end else begin
                    if(counter > 2'b00) begin
                        counter <= counter - 1; // Decrement when train_valid = 1 and train_taken = 0 (down to minimum of 0)
                    end
                end
            end
        end
    end

    assign state = counter;

endmodule
